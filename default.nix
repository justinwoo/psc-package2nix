{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "psc-package2nix";

  src = ./.;

  buildInputs = [
    pkgs.makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/bin/lib
    cp -r $src/lib $out/bin
    install -D -m555 -t $out/bin psc-package2nix

    wrapProgram $out/bin/psc-package2nix \
      --prefix PATH : ${pkgs.lib.makeBinPath [
        pkgs.nix
        pkgs.coreutils
        pkgs.perl
        pkgs.jq
        pkgs.nix-prefetch-git
      ]}
  '';
}
