{ pkgs ? import <nixpkgs> {} }:

let
  # this is how you would normally import psc-package2nix to your project
  psc-package2nix = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "psc-package2nix";
    # you should make sure to use nix-prefetch-github to get the latest rev and sha!
    rev = "b4d6a834ac124440a503f0510b8a9de95532b16c";
    sha256 = "0g9fq4j472bcr1x5na6mzr3av95xhvdmnlns1ncvsl4kqa8ix2zr";
  }) {};

in
  # we override the remote with the local definition here
  import ../. { inherit pkgs; }
