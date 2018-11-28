let
  pkgs = import <nixpkgs> {};

  precompiles = import ./precompiles.nix {};
  precompilesDrvs = builtins.attrValues precompiles.inputs;

  pp2n-utils = import ../utils.nix;

in pkgs.stdenv.mkDerivation {
  name = "install-deps";
  src = ./.;

  buildInputs = precompilesDrvs;

  shellHook = pp2n-utils.mkDefaultShellHook precompiles precompilesDrvs;
}
