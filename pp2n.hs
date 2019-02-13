module Main where

import qualified Data.List as List
import qualified Data.Maybe as Maybe
import qualified Data.Text as Text
import qualified System.Environment as Env
import qualified System.Exit as Exit
import qualified System.Process as Proc

newtype PP2N_SRC = PP2N_SRC String
newtype Globs = Globs [String]
newtype ModuleName = ModuleName String
newtype OutFilePath = OutFilePath String
type BundleArgs = (Maybe ModuleName, Maybe OutFilePath)

callSystem :: String -> [String] -> IO ()
callSystem cmd args = do
  let process = Proc.proc cmd args
  (_, _, _, handle) <- Proc.createProcess process
  exitCode <- Proc.waitForProcess handle
  case exitCode of
    Exit.ExitSuccess -> pure ()
    Exit.ExitFailure _ -> Exit.exitWith exitCode

readSystem :: String -> [String] -> IO String
readSystem cmd args = do
  let process = Proc.proc cmd args
  (exitCode, out, err) <- Proc.readCreateProcessWithExitCode process ""
  case exitCode of
    Exit.ExitSuccess -> do
      pure out
    _ -> do
      putStrLn $ "error while running " <> cmd <> ":"
      putStr err
      Exit.exitWith exitCode

install :: PP2N_SRC -> [String] -> IO ()
install pp2nSrc extraArgs = do
  let derivation = mkInstallDepsDerivation pp2nSrc
  callSystem "nix-shell" $ ["-E", derivation, "--run", "'exit'"] ++ extraArgs

getGlobs :: PP2N_SRC -> IO Globs
getGlobs pp2nSrc = do
  let globsDerivation = mkGetGlobsDerivation pp2nSrc
  out <- readSystem "nix-instantiate" ["--eval", "-E", globsDerivation]
  let quotesRemoved = List.filter (\x -> x /= '"') out
  pure $ Globs $ List.words quotesRemoved

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
  _ <- traverse print globs
  pure ()

bowerInstall :: PP2N_SRC -> IO ()
bowerInstall pp2nSrc = do
  let derivation = mkBowerInstallDepsDerivation pp2nSrc
  callSystem "nix-shell" ["-E", derivation, "--run", "'exit'"]

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
