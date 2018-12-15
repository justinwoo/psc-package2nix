{ pkgs ? import <nixpkgs> {}}:

import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "easy-purescript-nix";
  rev = "5b71ea53e25a1f99229ee0b657b37c46f6fc0a45";
  sha256 = "1qza198b93abr4klzvz55ccai99ji893j4kgv0dali827ryk7ph2";
})
