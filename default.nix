{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "psc-package2nix";

  src = pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "psc-package2nix";
    rev = "5dd99091a4ae081b94d53aa3495280f9a44f4432";
    sha256 = "03z61k5j8dp1avh14mxcw8rlcxic41szl3hb2wds9jfrmgh35vvm";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp psc-package2nix $out/bin
  '';
}
