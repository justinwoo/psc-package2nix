let
  pkgs = import <nixpkgs> {};

  packages = import ./packages.nix {};
  packageDrvs = builtins.attrValues packages.inputs;

  # you will want to fetch this likely by direct url or copy this into your project
  _pp2n-utils = import pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/justinwoo/psc-package2nix/fab30e8f9abbaf5fd8b009172473852b64531ebe/utils.nix";
    sha = "0rkqisfvpz5x8j2p0llv0yzgz5vnzy7fcfalp8nkymbshk8702gg";
  };

  pp2n-utils = import ../utils.nix;

in pkgs.stdenv.mkDerivation {
  name = "install-deps";
  shellHook = pp2n-utils.mkDefaultShellHook packages packageDrvs;
}
