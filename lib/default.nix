{ pkgs ? import <nixpkgs> {} }:

let
  easy-ps = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "d43588d63f6d352c6541e5b90279cda107fbd0f4";
    sha256 = "1dj9kkrs9iq22lpdqlplkrsr0hf97mxadnfr2ds0ir5fa4ksk8yf";
  });

in pkgs.stdenv.mkDerivation {
  name = "psc-package2nix-project";
  buildInputs = [
    easy-ps.inputs.purs
    easy-ps.inputs.psc-package2nix
  ];
}
