{ pkgs ? import <nixpkgs> {} }:

let
  psc-package2nix = import ../default.nix {};
  purs = import (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/justinwoo/easy-purescript-nix/d383972c82620a712ead4033db14110497bc2c9c/purs.nix";
    sha256 = "1d4dc40cwmi9xn7hwxmhrhgl29s327bqdzpsfz6lqjx2h4airh3a";
  }) { inherit pkgs; };

in pkgs.stdenv.mkDerivation {
  name = "psc-package2nix-project";
  buildInputs = [
    purs
    psc-package2nix
  ];
}
