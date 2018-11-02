let
  pkgs = import <nixpkgs> {};

  easy-ps = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "347ab7c91634462c2039c6c0641af5386c251a98";
    sha256 = "0njhcl7dq58b3kmjbz6ndsccv4pcmdxc5lg7p13115phcmznpn99";
  });

  psc-package2nix = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "psc-package2nix";
    rev = "414ba2f58e270dece3834021e380c41cd940b983";
    sha256 = "0lrw2k1gm4aamnlxi16syibyqi7i3nvx9bwzq889vd1p0sbzxs9x";
  }) {};

in pkgs.stdenv.mkDerivation {
  name = "test";
  src = ./.;

  buildInputs
    = [
      easy-ps.inputs.purs
      easy-ps.inputs.psc-package-simple
      psc-package2nix
    ];

}
