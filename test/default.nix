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
    rev = "edaf492e939decfebf3d0ab6b9f04ec1c317e028";
    sha256 = "06p1ggk38hmfd9461l4w822gavz7kizx05v9r2lb22qdsg3m94gd";
  }) {};

  packages = import ./packages.nix {};
  packageDrvs = builtins.attrValues packages.inputs;

  copyCmds = map (x: let target = ".psc-package/${packages.set}/${x.name}/${x.version}"; in ''
    mkdir -p ${target}
    cp --no-preserve=mode,ownership,timestamp -r ${toString x.outPath}/* ${target}
  '') packageDrvs;

in pkgs.stdenv.mkDerivation {
  name = "test";
  src = ./.;

  buildInputs
    = packageDrvs
    ++ [
      easy-ps.inputs.purs
      easy-ps.inputs.psc-package-simple
      psc-package2nix
    ];

  shellHook = ''
    mkdir -p .psc-package
  '' + toString copyCmds;
}
