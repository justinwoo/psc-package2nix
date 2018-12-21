packages:
drvs:

let
  mkCopyHook = import ./mkCopyHook.nix;
in builtins.toString (builtins.map (mkCopyHook packages) drvs)
