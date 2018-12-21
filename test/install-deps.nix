#! /usr/bin/env nix-shell
#! nix-shell ./install-deps.nix --run 'exit'

{ pkgs ? import <nixpkgs> {} }:

let
  packages = import ./packages.nix { inherit pkgs; };

  # you will want to fetch this likely by direct url or copy this into your project
  # _pp2n-utils = import pkgs.fetchurl {
  #   url = "https://raw.githubusercontent.com/justinwoo/psc-package2nix/SOMEREV/utils.nix";
  #   sha = "SOMESHA";
  # };
  # easy-ps = import ./easy-ps.nix { inherit pkgs; };
  # mkInstallPackages = import (easy-ps.inputs.psc-package2nix.src + "/nix/mkInstallPackages.nix");

  mkInstallPackages = import ../nix/mkInstallPackages.nix;

in mkInstallPackages {
  inherit packages;
}
