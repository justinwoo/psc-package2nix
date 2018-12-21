{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "psc-package2nix";

  src = ./.;

  buildInputs = [
    pkgs.makeWrapper
  ];

  installPhase = ''
    PERL_LIB=$out/lib/perl5/site_perl/${pkgs.perl.version}
    mkdir -p $PERL_LIB
    cp -v -r $src/lib/* $PERL_LIB

    mkdir -p $out/bin/lib
    install -D -m555 -t $out/bin psc-package2nix

    wrapProgram $out/bin/psc-package2nix \
      --prefix PERL5LIB : $PERL_LIB \
      --prefix PATH : ${pkgs.lib.makeBinPath [
        pkgs.nix
        pkgs.coreutils
        pkgs.perl
        pkgs.jq
        pkgs.nix-prefetch-git
      ]}
  '';
}
