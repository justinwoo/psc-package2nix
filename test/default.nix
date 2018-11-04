let
  pkgs = import <nixpkgs> {};

  easy-ps = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "347ab7c91634462c2039c6c0641af5386c251a98";
    sha256 = "0njhcl7dq58b3kmjbz6ndsccv4pcmdxc5lg7p13115phcmznpn99";
  });

  psc-package2nix = import ./psc-package2nix.nix { inherit pkgs; };

in pkgs.stdenv.mkDerivation {
  name = "test";
  src = ./.;

  buildInputs
    = [
      pkgs.jq
      pkgs.nix-prefetch-git
      easy-ps.inputs.purs
      easy-ps.inputs.psc-package-simple
      psc-package2nix
    ];

}
