rec {
  mkCopyHook = packages: drv:
  let target = ".psc-package/${packages.set}/${drv.name}/${drv.version}";
  in ''
    if [ ! -e ${target} ]; then
    mkdir -p ${target}
    cp --no-preserve=mode,ownership,timestamp -r ${toString drv.outPath}/* ${target}
    fi
  '';

  mkDefaultShellHook = packages: drvs: toString (map (mkCopyHook packages) drvs);

  mkInstallPackages = nixpkgs: packages:
    let packageDrvs = builtins.attrValues packages.inputs;
    in nixpkgs.stdenv.mkDerivation({
      name = "install-deps-${packages.set}";
      buildInputs = packageDrvs;
      shellHook = mkDefaultShellHook packages packageDrvs;
    });
}
