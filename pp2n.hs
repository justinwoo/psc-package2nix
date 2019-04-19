module Main where

import qualified Control.Concurrent.Async.Pool as Async
import qualified Data.List as List
import qualified Data.Maybe as Maybe
import qualified Data.Set as Set
import qualified Data.Text as Text
import qualified System.Directory as Dir
import qualified System.Environment as Env
import qualified System.Exit as Exit
import qualified System.Process as Proc

newtype PP2N_SRC = PP2N_SRC String
newtype Globs = Globs [String]
newtype ModuleName = ModuleName String
newtype OutFilePath = OutFilePath String
newtype PscPackageJsonPath = PscPackageJsonPath String
type BundleArgs = (Maybe ModuleName, Maybe OutFilePath)

quote :: String -> String
quote s = "\"" <> s <> "\""

strip :: String -> String
strip = Text.unpack . Text.strip . Text.pack

callBash :: String -> IO ()
callBash cmd = callSystem "bash" ["-c", cmd]

callSystem :: String -> [String] -> IO ()
callSystem cmd args = do
  let process = Proc.proc cmd args
  (_, _, _, handle) <- Proc.createProcess process
  exitCode <- Proc.waitForProcess handle
  case exitCode of
    Exit.ExitSuccess -> pure ()
    _ -> do
      putStrLn $ "error while running " <> cmd <> ":"
      Exit.exitWith exitCode

readBash :: String -> IO String
readBash cmd = readSystem "bash" ["-c", cmd]

readSystem :: String -> [String] -> IO String
readSystem cmd args = do
  let process = Proc.proc cmd args
  (exitCode, out, err) <- Proc.readCreateProcessWithExitCode process ""
  case exitCode of
    Exit.ExitSuccess -> do
      pure . strip $ out
    _ -> do
      putStrLn $ "error while running " <> cmd <> ":"
      putStr err
      Exit.exitWith exitCode

install :: PP2N_SRC -> [String] -> IO ()
install pp2nSrc extraArgs = do
  let derivation = mkInstallDepsDerivation pp2nSrc
  _ <- ensurePscPackageSet
  callSystem "nix-shell" $ ["-E", derivation, "--run", "'exit'"] ++ extraArgs

getGlobs :: PP2N_SRC -> IO Globs
getGlobs pp2nSrc = do
  let globsDerivation = mkGetGlobsDerivation pp2nSrc
  out <- readSystem "nix-instantiate" ["--eval", "-E", globsDerivation]
  let quotesRemoved = Text.words . Text.filter (\x -> x /= '"') $ Text.pack out
  pure $ Globs $ Text.unpack <$> quotesRemoved

build :: PP2N_SRC -> [String] -> IO ()
build pp2nSrc extraArgs = do
  Globs globs <- getGlobs pp2nSrc
  callSystem "purs"
     $ ["compile"] ++ extraArgs
    ++ globs ++ ["src/**/*.purs", "test/**/*.purs"]

test :: PP2N_SRC -> Maybe ModuleName -> IO ()
test pp2nSrc mModuleName = do
  build pp2nSrc []
  Proc.callCommand runCmd
  putStrLn "tests succeeded."
  where
    (ModuleName moduleName) = Maybe.fromMaybe (ModuleName "Test.Main") mModuleName
    runCmd
      = Text.unpack
      . Text.replace (Text.pack "moduleName") (Text.pack moduleName)
      . Text.pack
      $ "node -e 'require(\"./output/moduleName\").main()'"

bundle :: BundleArgs -> IO ()
bundle bundleArgs = do
  let
    (ModuleName moduleName, OutFilePath targetPath) = prepareBundleDefaults bundleArgs
    cmd
      = Text.unpack
      . Text.replace (Text.pack "moduleName") (Text.pack moduleName)
      . Text.replace (Text.pack "targetPath") (Text.pack targetPath)
      . Text.pack
      $ "purs bundle './output/*/*.js' -m moduleName --main moduleName -o targetPath"
  Proc.callCommand cmd
  putStrLn $ "bundled " <> moduleName <> " to " <> targetPath

prepareBundleDefaults :: BundleArgs -> (ModuleName, OutFilePath)
prepareBundleDefaults (mModuleName, mTargetPath) =
  ( Maybe.fromMaybe (ModuleName "Main") mModuleName
  , Maybe.fromMaybe (OutFilePath "index.js") mTargetPath
  )

sources :: PP2N_SRC -> IO ()
sources pp2nSrc = do
  Globs globs <- getGlobs pp2nSrc
  -- globs should not be quoted in sources output
  _ <- traverse putStrLn globs
  pure ()

bowerInstall :: PP2N_SRC -> IO ()
bowerInstall pp2nSrc = do
  let derivation = mkBowerInstallDepsDerivation pp2nSrc
  callSystem "nix-shell" ["-E", derivation, "--run", "'exit'"]

ensurePscPackageSet :: IO (PscPackageJsonPath, Set, Source, Hash)
ensurePscPackageSet = do
  sourceName <- readSystem "jq" [".source", pscPackageJson, "-r"]
  setName <- readSystem "jq" [".set", pscPackageJson, "-r"]
  let set = Set setName
  let source = Source sourceName
  let packageSetDir = ".psc-package/" <> setName <> "/.set"
  let packagesJson = packageSetDir <> "/packages.json"

  let packageSetHashFilePath = pscPackage2NixDir <> "/" <> escapeSource sourceName <> "@" <> setName
  hasPackageSetHashFilePath <- Dir.doesPathExist packageSetHashFilePath

  hasPackagesJson <- Dir.doesPathExist packagesJson
  if hasPackagesJson && hasPackageSetHashFilePath then pure () else do
    sha <- readBash $ "nix-prefetch-git " <> sourceName <> " --rev " <> setName <> " --quiet | jq '.sha256' -r"

    -- check against empty prefetch result
    -- this is because nix-prefetch-git doesn't error on non matches
    if (sha /= "0sjjj9z1dhilhpc8pq4154czrb79z9cm044jvn75kxcjv6v5l2m5") then pure () else do
      fail "Fetched an empty git repository for the package set. Verify that the package set is real."

    -- save the sha to a file to read
    writeFile packageSetHashFilePath sha

    let expr = mkPackageSetExpr set source (Hash sha)
    existing <- Dir.doesPathExist packageSetDir
    if existing
      then do Dir.removeDirectory packageSetDir
      else pure ()
    callSystem "nix-build" ["-E", expr, "-o", packageSetDir]
    putStrLn $ "built package set to " <> packageSetDir

  hash <- Hash <$> readFile packageSetHashFilePath

  pure (PscPackageJsonPath packagesJson, set, source, hash)

  where
    escapeSource
      = Text.unpack
      . Text.replace (Text.pack ":") (Text.pack "_")
      . Text.replace (Text.pack "/") (Text.pack "-")
      . Text.pack

pscPackage2Nix :: IO ()
pscPackage2Nix = do
  callBash $ "mkdir -p " <> pscPackage2NixDir
  (packagesJson, set, source, hash) <- ensurePscPackageSet

  depends <- readBash $ "jq '.depends | values[]' -r " <> pscPackageJson
  let directDeps = Dep <$> List.lines depends
  deps <- Set.toList <$> loop (getDeps packagesJson) Set.empty directDeps

  derivations <- Async.withTaskGroup 10 $ \taskgroup ->
    Async.mapTasks taskgroup $ getDerivation packagesJson <$> deps
  let packages = mkPackagesExpr derivations set source hash

  writeFile "packages.nix" packages
  putStrLn "wrote packages.nix"
  where
    loop _ set [] = pure set
    loop f set (x:xs) = do
      set' <- f x set
      loop f set' xs

    getDeps :: PscPackageJsonPath -> Dep -> Set.Set Dep -> IO (Set.Set Dep)
    getDeps packagesJsonPath@(PscPackageJsonPath packagesJson) dep@(Dep depName) visited =
      if Set.member dep visited then pure visited else do
        let visited' = Set.insert dep visited
        transitive <- readBash $ "jq '." <> quote depName <> ".dependencies | values[]' " <> packagesJson <> " -r"
        loop (getDeps packagesJsonPath) visited' (Dep <$> List.lines transitive)

    getDerivation :: PscPackageJsonPath -> Dep -> IO Derivation
    getDerivation (PscPackageJsonPath packagesJson) dep@(Dep depName) = do
      let depNameQuoted = quote depName

      version <- readBash $ "jq '." <> depNameQuoted <> ".version' -r " <> packagesJson
      repo <- readBash $ "jq '." <> depNameQuoted <> ".repo' -r " <> packagesJson

      let hashFilePath = pscPackage2NixDir <> "/" <> depName <> "-" <> version
      hasHash <- Dir.doesPathExist hashFilePath

      if hasHash then pure () else do
        callBash $ "echo fetching " <> hashFilePath
        callBash $ "nix-prefetch-git " <> repo <> " --rev " <> version <> " --quiet | jq '.sha256' -r > " <> hashFilePath
      hash <- strip <$> readFile hashFilePath

      pure $ mkDepDerivation dep (Version version) (Repo repo) (Hash hash)

help :: IO ()
help = putStrLn usageText

main :: IO ()
main = do
  args <- Env.getArgs
  pp2nSrc <- PP2N_SRC <$> Env.getEnv "PP2N_SRC"

  case args of
    "install" : rest -> install pp2nSrc rest
    "build" : rest -> build pp2nSrc rest
    "sources" : _ -> sources pp2nSrc
    "bower-install" : _ -> bowerInstall pp2nSrc
    "test" : rest -> test pp2nSrc (parseTestArgs rest)
    "bundle" : bundleArgs -> bundle (parseBundleArgs (Nothing, Nothing) bundleArgs)
    "psc-package2nix" : _ -> pscPackage2Nix
    "help" : _ -> help
    [] -> help
    _ -> do
      putStrLn $ "unknown args passed passed to pp2n: " ++ show args

parseTestArgs :: [String] -> Maybe ModuleName
parseTestArgs ("-m" : moduleName : _) = Just (ModuleName moduleName)
parseTestArgs xs@(_ : _) = fail $ "Unknown args passed to test: " <> show xs
parseTestArgs [] = Nothing

parseBundleArgs :: BundleArgs -> [String] -> BundleArgs
parseBundleArgs (_, r) ("-m" : moduleName : xs) = parseBundleArgs (Just (ModuleName moduleName), r) xs
parseBundleArgs (l, _) ("-o" : out : xs) = parseBundleArgs (l, Just (OutFilePath out)) xs
parseBundleArgs lr (_ : xs) = parseBundleArgs lr xs
parseBundleArgs lr [] = lr

mkInstallDepsDerivation :: PP2N_SRC -> String
mkInstallDepsDerivation (PP2N_SRC pp2nSrc) = "\
\let mkInstallPackages = import " ++ pp2nSrc ++ "/nix/mkInstallPackages.nix;\
\    packages = import ./packages.nix {};\
\in mkInstallPackages { inherit packages; }"

mkGetGlobsDerivation :: PP2N_SRC -> String
mkGetGlobsDerivation (PP2N_SRC pp2nSrc) = "\
\let getGlobs = import " ++ pp2nSrc ++ "/nix/getGlobs.nix;\
\in builtins.toString (getGlobs (import ./packages.nix {}))"

mkBowerInstallDepsDerivation :: PP2N_SRC -> String
mkBowerInstallDepsDerivation (PP2N_SRC pp2nSrc) = "\
\let mkInstallBowerStyle = import " ++ pp2nSrc ++ "/nix/mkInstallBowerStyle.nix;\
\    packages = import ./packages.nix {};\
\in mkInstallBowerStyle { inherit packages; }"

usageText :: String
usageText = "\
\pp2n - a small utility for Psc-Package2Nix that allows for the most commonly needed actions from Psc-Package\n\
\\n\
\  Usage: pp2n (install | build | sources | help | bower-install)\n\
\\n\
\Available commands:\n\
\  psc-package2nix\n\
\    Generate a nix expression of packages from psc-package.json\n\
\  install [passthrough args for nix-shell]\n\
\    Install dependencies from packages.nix in Psc-Package style\n\
\  build [passthrough args for purs]\n\
\    Build the (psc-package style) project, including 'src/**/*.purs' and 'test/**/*.purs', with passthrough args for purs.\n\
\  sources\n\
\    Get the sources of dependencies installed by psc-package2nix in packages.nix.\n\
\  bower-install\n\
\    Install dependencies from packages.nix in Bower style\n\
\  test [-m Test.Main]\n\
\    Build the (psc-package style) project, including 'src/**/*.purs' and 'test/**/*.purs', then run the tests with node.\n\
\    Uses Test.Main by default.\n\
\  bundle [-m Main -o index.js]\n\
\    Bundle the project, with optional main and target path arguments."

-- Nix Derivation String
newtype Derivation = Derivation {unDerivation :: String}
newtype Set = Set String
newtype Source = Source String
newtype Dep = Dep String deriving (Eq, Ord, Show)
newtype Version = Version String
newtype Repo = Repo String
newtype Hash = Hash String

mkDepDerivation :: Dep -> Version -> Repo -> Hash -> Derivation
mkDepDerivation (Dep dep) (Version version) (Repo repo) (Hash hash) = Derivation $ "\
\    " <> quote dep <> " = pkgs.stdenv.mkDerivation {\n\
\      name = " <> quote dep <> ";\n\
\      version = " <> quote version <> ";\n\
\      src = pkgs.fetchgit {\n\
\        url = " <> quote repo <> ";\n\
\        rev = " <> quote version <> ";\n\
\        sha256 = " <> quote hash <> ";\n\
\      };\n\
\      phases = \"installPhase\";\n\
\      installPhase = \"ln -s $src $out\";\n\
\    };"

mkPackagesExpr :: [Derivation] -> Set -> Source -> Hash -> String
mkPackagesExpr drvs (Set set) (Source source) (Hash hash)
  | derivations <- List.intercalate "\n\n" $ unDerivation <$> drvs = "\
\# This file was generated by Psc-Package2Nix\n\
\# You will not want to edit this file.\n\
\# To change the contents of this file, first fork Psc-Package2Nix\n\
\# And edit the $file_template\n\
\\n\
\{ pkgs ? import <nixpkgs> {} }:\n\
\\n\
\let\n\
\  inputs = {\n\n\
\" <> derivations <> "\n\
\};\n\
\\n\
\in {\n\
\  inherit inputs;\n\
\\n\
\  set = " <> quote set <> ";\n\
\  source = " <> quote source <> ";\n\
\  sha256 = " <> quote hash <> ";\n\
\}\n"

mkPackageSetExpr :: Set -> Source -> Hash -> String
mkPackageSetExpr (Set set) (Source source) (Hash hash) = "\
\(import <nixpkgs> {}).fetchgit {\n\
\    url = " <> quote source <> ";\n\
\    rev = " <> quote set <> ";\n\
\    sha256 = " <> quote hash <> ";\n\
\}"

pscPackage2NixDir :: String
pscPackage2NixDir = ".psc-package2nix"

pscPackageJson :: String
pscPackageJson = "psc-package.json"
