{ pkgs ? import <nixpkgs> {} }:

let
  psc-package2nix = import ../default.nix {};
  easy-ps = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "0debbe629de2c2d6278ba772e40a0851a57b9d2f";
    sha256 = "1k83gsfgg4p4c2f6ls467fm8v1ixmy1y3jly8id5wc71zc7szs1q";
  });

in pkgs.stdenv.mkDerivation {
  name = "psc-package2nix-project";
  buildInputs = [
    easy-ps.inputs.purs
    psc-package2nix
  ];
}
