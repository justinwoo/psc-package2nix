{ purs
, packages
, mkDerivation ? (import <nixpkgs> {}).stdenv.mkDerivation
, src
, srcPath ? ''"src/**/*.purs"''
}:

let
  wrapQuote = import ./wrapQuote.nix;
  getDirectGlobs = import ./getDirectGlobs.nix;

  globsList = builtins.map wrapQuote (getDirectGlobs packages);
  globs = builtins.toString globsList;

in mkDerivation {
  name = "psc-package2nix-compile-direct";
  inherit src;
  installPhase = ''
    ${purs}/bin/purs compile ${globs} ${srcPath}
    mkdir -p $out
    mv output $out
  '';
}
