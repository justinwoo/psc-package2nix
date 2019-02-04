module Main where

import qualified Data.List as List
import qualified System.Environment as Env
import qualified System.Exit as Exit
import qualified System.Process as Proc

newtype PP2N_SRC = PP2N_SRC String
newtype Globs = Globs [String]

callSystem :: String -> [String] -> IO ()
callSystem cmd args = do
  let process = Proc.proc cmd args
  (_, _, _, handle) <- Proc.createProcess process
  exitCode <- Proc.waitForProcess handle
  Exit.exitWith exitCode

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

install :: PP2N_SRC -> IO ()
install pp2nSrc = do
  let derivation = mkInstallDepsDerivation pp2nSrc
  callSystem "nix-shell" ["-E", derivation, "--run", "'exit'"]

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
help = putStr usageText

main :: IO ()
main = do
  args <- Env.getArgs
  pp2nSrc <- PP2N_SRC <$> Env.getEnv "PP2N_SRC"

  case args of
    "install" : _ -> install pp2nSrc
    "build" : rest -> build pp2nSrc rest
    "sources" : _ -> sources pp2nSrc
    "bower-install" : _ -> bowerInstall pp2nSrc
    "help" : _ -> help
    [] -> help
    _ -> do
      putStrLn $ "unknown args passed passed to pp2n: " ++ show args

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
\ pp2n - a small utility for Psc-Package2Nix that allows for the most commonly needed actions from Psc-Package\n\
\\n\
\ Usage: pp2n (install | build | sources | help | bower-install)\n\
\\n\
\ Available commands:\n\
\   install\n\
\     Install dependencies from packages.nix in Psc-Package style\n\
\   build [passthrough args]\n\
\     Build the (psc-package style) project, including 'src/**/*.purs' and 'test/**/*.purs', with passthrough args for purs.\n\
\   sources\n\
\     Get the sources of dependencies installed by psc-package2nix in packages.nix.\n\
\   bower-install\n\
\     Install dependencies from packages.nix in Bower style\n"
