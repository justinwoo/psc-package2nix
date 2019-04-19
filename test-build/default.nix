{ pkgs ? import <nixpkgs> {} }:

let
  psc-package2nix = import ../default.nix { inherit pkgs; };

  easy-ps = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "87c49e20c721bbc160216f6fd0f0806818e0b760";
    sha256 = "0j8knp9h3gbcl5vcd7yvink07yy482l24ix4m6yinfbi4bpmjsy5";
  });

  mkCompileDirect = import "${psc-package2nix.src}/nix/mkCompileDirect.nix";

  packages = import ./packages.nix { inherit pkgs; };

in mkCompileDirect {
  inherit packages;
  inherit (easy-ps) purs;
  src = ./.;
}
