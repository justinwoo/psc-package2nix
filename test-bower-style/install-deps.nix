let
  pkgs = import <nixpkgs> {};
  packages = import ./packages.nix {};
  pp2n-utils = import ../utils.nix;

in pp2n-utils.mkInstallBowerStyle pkgs packages
