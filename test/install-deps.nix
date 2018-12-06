let
  pkgs = import <nixpkgs> {};
  packages = import ./packages.nix {};

  # you will want to fetch this likely by direct url or copy this into your project
  # _pp2n-utils = import pkgs.fetchurl {
  #   url = "https://raw.githubusercontent.com/justinwoo/psc-package2nix/SOMEREV/utils.nix";
  #   sha = "SOMESHA";
  # };

  pp2n-utils = import ../utils.nix;

in pp2n-utils.mkInstallPackages pkgs packages
