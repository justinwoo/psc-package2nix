{ purs
, packages
, mkDerivation ? (import <nixpkgs> {}).stdenv.mkDerivation
, src ? ''"src/**/*.purs"''
}:

let
  getGlobsQuoted = import ./getGlobsQuoted.nix;
  globs = builtins.toString (getGlobsQuoted packages);
in mkDerivation {
  name = "compile";
  buildInputs = [purs];
  shellHook = "purs compile ${globs} ${src}";
}
