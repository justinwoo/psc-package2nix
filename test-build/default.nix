{ pkgs ? import <nixpkgs> {} }:

let
  psc-package2nix = import ../default.nix { inherit pkgs; };

  easy-ps = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "1e5698a1cba964df78f95a70bf262b9c097cd224";
    sha256 = "1ay2qfkd7fiqjp32vs5fg2d6zfbjxxy5hhpb7qm27ahpfxmqx43d";
  });

  mkCompileDirect = import "${psc-package2nix.src}/nix/mkCompileDirect.nix";

  packages = import ./packages.nix { inherit pkgs; };

in mkCompileDirect {
  inherit packages;
  inherit (easy-ps) purs;
  src = ./.;
}
