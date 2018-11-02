{ pkgs ? import <nixpkgs> {} }:

let
  inputs = {
    bifunctors = pkgs.stdenv.mkDerivation {
      name = "bifunctors";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-bifunctors.git";
        rev = "v4.0.0";
        sha256 = "1bdra5fbkraglqrrm484vw8h0wwk48kzkn586v4y7fg106q1q386";
      };
      dontInstall = true;
      buildPhase = "cp -r $src $out";
    };
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
    control = pkgs.stdenv.mkDerivation {
      name = "control";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-control.git";
        rev = "v4.0.0";
        sha256 = "00f4s11djyjnsjvgjjkbsvx671j1y32l2nh2j49a15a2cdk3i633";
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
    foldable-traversable = pkgs.stdenv.mkDerivation {
      name = "foldable-traversable";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-foldable-traversable.git";
        rev = "v4.0.0";
        sha256 = "0dscsshm80j08qyv504mj77xb4f1bic9jbzqlgd2vbx6wpdcv9ll";
      };
      dontInstall = true;
      buildPhase = "cp -r $src $out";
    };
    invariant = pkgs.stdenv.mkDerivation {
      name = "invariant";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-invariant.git";
        rev = "v4.0.0";
        sha256 = "1g4dahf9swkw45i3x6kgl7x0gvfv3r5zzbfrazspg73vdxll2na5";
      };
      dontInstall = true;
      buildPhase = "cp -r $src $out";
    };
    maybe = pkgs.stdenv.mkDerivation {
      name = "maybe";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-maybe.git";
        rev = "v4.0.0";
        sha256 = "06mm4a6lbp5by14vms3lyhqp64211lwnq1dqbaazvdp0afykx1z5";
      };
      dontInstall = true;
      buildPhase = "cp -r $src $out";
    };
    newtype = pkgs.stdenv.mkDerivation {
      name = "newtype";
      version = "v3.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-newtype.git";
        rev = "v3.0.0";
        sha256 = "0qvk9p41miy806b05b4ikbr3if0fcyc35gfrwd2mflcxxp46011c";
      };
      dontInstall = true;
      buildPhase = "cp -r $src $out";
    };
    orders = pkgs.stdenv.mkDerivation {
      name = "orders";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-orders";
        rev = "v4.0.0";
        sha256 = "13p1sm4dxkmxhld9x5qqg62iiajjb3qpzs66c1r24y5fs4zsfry4";
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
