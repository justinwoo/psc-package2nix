{ pkgs ? import <nixpkgs> {} }:

let
  # this is how you would normally import psc-package2nix to your project
  psc-package2nix = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "psc-package2nix";
    # you should make sure to use nix-prefetch-github to get the latest rev and sha!
    rev = "4135235e9577bb130e23b33931a2e228a34fcd34";
    sha256 = "087641lyvpwvd51qc3zgfk8nb4n7fhp0cmg4f2f7rvm9k0ha456v";
  }) {};

in
  # we override the remote with the local definition here
  import ../. { inherit pkgs; }
