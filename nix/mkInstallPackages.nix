{ packages
, mkDerivation ? (import <nixpkgs> {}).stdenv.mkDerivation
}:

let
  mkDefaultShellHook = import ./mkDefaultShellHook.nix;
  packageDrvs = builtins.attrValues packages.inputs;
in mkDerivation {
  name = "install-deps-${packages.set}";
  buildInputs = packageDrvs;
  shellHook = mkDefaultShellHook packages packageDrvs;
}
