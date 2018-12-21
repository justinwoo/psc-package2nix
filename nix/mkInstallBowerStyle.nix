{ packages
, mkDerivation ? (import <nixpkgs> {}).stdenv.mkDerivation
}:

let
  mkBowerStyleShellHook = import ./mkBowerStyleShellHook.nix;
  packageDrvs = builtins.attrValues packages.inputs;
in mkDerivation {
  name = "install-bower-style";
  buildInputs = packageDrvs;
  shellHook = mkBowerStyleShellHook packageDrvs;
}
