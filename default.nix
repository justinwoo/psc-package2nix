{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "psc-package2nix";

  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    cp psc-package2nix $out/bin
  '';
}
