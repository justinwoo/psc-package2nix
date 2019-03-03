{ pkgs ? import <nixpkgs> {} }:

let
  ghc = pkgs.ghc.withPackages (x: [
    (pkgs.haskell.lib.overrideCabal x.async-pool (old: {
      jailbreak = true;
      doCheck = false;
    }))
  ]);

in pkgs.stdenv.mkDerivation {
  name = "psc-package2nix";

  src = ./.;

  buildInputs = [
    pkgs.makeWrapper
    ghc
  ];

  installPhase = ''
    mkdir -p $out/bin

    install -D -m555 -t $out/bin psc-package2nix
    wrapProgram $out/bin/psc-package2nix \
      --prefix PP2N : $out/bin/pp2n \

    ghc -threaded -rtsopts -with-rtsopts="-N" -o pp2n pp2n.hs
    install -D -m555 -t $out/bin pp2n
    wrapProgram $out/bin/pp2n \
      --prefix PP2N_SRC : $src \
      --prefix PATH : $out/bin:${pkgs.lib.makeBinPath [
        pkgs.coreutils
        pkgs.jq
        pkgs.nix
        pkgs.nix-prefetch-git
      ]}

    mkdir -p $out/etc/bash_completion.d/
    cp $src/pp2n-completion.bash $out/etc/bash_completion.d/pp2n-completion.bash
  '';
}
