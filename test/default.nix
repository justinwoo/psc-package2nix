{ pkgs ? import <nixpkgs> {} }:

let
  easy-ps = import ./easy-ps.nix { inherit pkgs; };

  psc-package2nix = import ./psc-package2nix.nix { inherit pkgs; };

in pkgs.stdenv.mkDerivation {
  name = "test";
  buildInputs = [
    easy-ps.inputs.purs
    easy-ps.inputs.psc-package-simple
    psc-package2nix
  ];
}
