{ pkgs ? import <nixpkgs> {} }:

let
  psc-package2nix = import ../default.nix {};

  easy-ps = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "a40defe4a94a7c5e07b48356591a076da2f45112";
    sha256 = "0kx1zsmf5d8hyy3wym9391p4l6xfhfw0iqqm7mrb7517lsxza1x6";
  });

in pkgs.stdenv.mkDerivation {
  name = "psc-package2nix-project";
  buildInputs = [
    easy-ps.purs
    easy-ps.spago
    psc-package2nix
  ];
}
