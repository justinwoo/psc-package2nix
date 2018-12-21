{ pkgs ? import <nixpkgs> {} }:

let
  easy-ps = import ./easy-ps.nix { inherit pkgs; };
  psc-package2nix = import ./psc-package2nix.nix { inherit pkgs; };

in pkgs.stdenv.mkDerivation {
  name = "test";
  buildInputs = [
    easy-ps.inputs.purs
    psc-package2nix
  ];
}
