{ pkgs ? import <nixpkgs> {} }:

let
  inputs = {
    console = pkgs.stdenv.mkDerivation {
      name = "console";
      version = "v4.1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-console.git";
        rev = "v4.1.0";
        sha256 = "1rc9b53q0l7g37113nspdcxcysg19wfq0l9d84gys8dp3q9n8vbf";
      };
      dontInstall = true;
      buildPhase = "cp -r $src $out";
    };
    effect = pkgs.stdenv.mkDerivation {
      name = "effect";
      version = "v2.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-effect.git";
        rev = "v2.0.0";
        sha256 = "0l46xqz39khf2c779d8mvax1fp2phy5sf8qdn31x67dz389mjr81";
      };
      dontInstall = true;
      buildPhase = "cp -r $src $out";
    };
    prelude = pkgs.stdenv.mkDerivation {
      name = "prelude";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-prelude.git";
        rev = "v4.0.0";
        sha256 = "1jl75yj35mjd0shn084mzi07f560sg4wxwmmkdg2vm38hs89ygng";
      };
      dontInstall = true;
      buildPhase = "cp -r $src $out";
    };

  };

in {
  inherit inputs;

  set = "psc-0.12.0";
  source = "https://github.com/purescript/package-sets.git";
}
