drvs:

let
  mkBowerStyleCopyHook = import ./mkBowerStyleCopyHook.nix;
in builtins.toString (builtins.map mkBowerStyleCopyHook drvs)
