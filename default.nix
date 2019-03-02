{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "psc-package2nix";

  src = ./.;

  buildInputs = [
    pkgs.makeWrapper
    (pkgs.ghc.withPackages (x: [ x.async-pool ]))
  ];

  installPhase = ''
    mkdir -p $out/bin

    install -D -m555 -t $out/bin psc-package2nix
    wrapProgram $out/bin/psc-package2nix \
      --prefix PP2N_SRC : $src \

    ghc -o pp2n pp2n.hs
    install -D -m555 -t $out/bin pp2n
    wrapProgram $out/bin/pp2n \
      --prefix PP2N_SRC : $src \
      --prefix PATH : $out/bin:${pkgs.lib.makeBinPath [
        pkgs.coreutils
        pkgs.jq
        pkgs.nix
      ]}

    mkdir -p $out/etc/bash_completion.d/
    cp $src/pp2n-completion.bash $out/etc/bash_completion.d/pp2n-completion.bash
  '';
}
