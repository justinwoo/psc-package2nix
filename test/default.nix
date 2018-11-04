let
  pkgs = import <nixpkgs> {};

  easy-ps = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "347ab7c91634462c2039c6c0641af5386c251a98";
    sha256 = "0njhcl7dq58b3kmjbz6ndsccv4pcmdxc5lg7p13115phcmznpn99";
  });

  # this is how you would normally import psc-package2nix to your project
  _psc-package2nix = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "psc-package2nix";
    # you should make sure to use nix-prefetch-github to get the latest rev and sha!
    rev = "a99092bfe9c32e0df9a826ccc509bd02b7b192c1";
    sha256 = "0296jb8b47zxnnhrjp4ky1mj835jff59sx4przix652mclsy13r3";
  }) {};

  # we override the remote with the local definition here
  psc-package2nix = import ../. {};

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
