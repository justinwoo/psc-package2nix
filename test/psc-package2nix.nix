{ pkgs ? import <nixpkgs> {} }:

let
  # this is how you would normally import psc-package2nix to your project
  psc-package2nix = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "psc-package2nix";
    # you should make sure to use nix-prefetch-github to get the latest rev and sha!
    rev = "a99092bfe9c32e0df9a826ccc509bd02b7b192c1";
    sha256 = "0296jb8b47zxnnhrjp4ky1mj835jff59sx4przix652mclsy13r3";
  }) {};

in
  # we override the remote with the local definition here
  import ../. { inherit pkgs; }
