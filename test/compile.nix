#! /usr/bin/env nix-shell
#! nix-shell ./compile.nix --run exit

{ pkgs ? import <nixpkgs> {} }:

let
  easy-ps = import ./easy-ps.nix { inherit pkgs; };
  packages = import ./packages.nix { inherit pkgs; };
  utils = import ../utils.nix;

in utils.mkCompilePscPackages {
  inherit (easy-ps.inputs) purs;
  inherit packages;
}
