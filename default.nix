{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "psc-package2nix";

  src = ./.;

  buildInputs = [
    pkgs.makeWrapper
  ];

  installPhase = ''
    install -D -m555 -t $out/bin psc-package2nix

    wrapProgram $out/bin/psc-package2nix \
      --prefix PATH : ${pkgs.lib.makeBinPath [
        pkgs.coreutils
        pkgs.perl
        pkgs.git
        pkgs.jq
        pkgs.nix-prefetch-git
      ]}
  '';
}
