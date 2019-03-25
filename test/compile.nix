#! /usr/bin/env nix-shell
#! nix-shell ./compile.nix --run exit

{ pkgs ? import <nixpkgs> {} }:

let
  purs = import (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/justinwoo/easy-purescript-nix/d383972c82620a712ead4033db14110497bc2c9c/purs.nix";
    sha256 = "1d4dc40cwmi9xn7hwxmhrhgl29s327bqdzpsfz6lqjx2h4airh3a";
  }) { inherit pkgs; };
  packages = import ./packages.nix { inherit pkgs; };
  utils = import ../utils.nix;

in utils.mkCompilePscPackages {
  inherit purs;
  inherit packages;
}
