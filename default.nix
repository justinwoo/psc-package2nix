{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "psc-package2nix";

  src = ./.;

  buildInputs = [
    pkgs.makeWrapper
  ];

  installPhase = ''
    PERL_LIB=$out/lib/perl5/site_perl/${pkgs.perl}
    mkdir -p $PERL_LIB
    cp -v -r $src/lib/* $PERL_LIB

    mkdir -p $out/bin

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

    install -D -m555 -t $out/bin pp2n
    wrapProgram $out/bin/pp2n \
      --prefix PERL5LIB : $PERL_LIB \
      --prefix PP2N_SRC : $src \
      --prefix PATH : $out/bin:${pkgs.lib.makeBinPath [
        pkgs.nix
        pkgs.coreutils
        pkgs.perl
      ]}
  '';
}
