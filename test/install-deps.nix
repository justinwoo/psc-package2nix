let
  pkgs = import <nixpkgs> {};

  packages = import ./packages.nix {};
  packageDrvs = builtins.attrValues packages.inputs;

  copyCmds = map (x: let target = ".psc-package/${packages.set}/${x.name}/${x.version}"; in ''
    mkdir -p ${target}
    cp --no-preserve=mode,ownership,timestamp -r ${toString x.outPath}/* ${target}
  '') packageDrvs;

in pkgs.stdenv.mkDerivation {
  name = "install-deps";
  src = ./.;

  buildInputs = packageDrvs;

  shellHook = toString copyCmds;
}
