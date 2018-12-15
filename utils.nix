rec {
  mkCopyHook = packages: drv:
  let target = ".psc-package/${packages.set}/${drv.name}/${drv.version}";
  in ''
    if [ ! -e ${target} ]; then
      echo "Installing ${target}."
      mkdir -p ${target}
      cp --no-preserve=mode,ownership,timestamp -r ${toString drv.outPath}/* ${target}
    else
      echo "${target} already exists. Skipping."
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

  mkBowerStyleCopyHook = drv:
    let target = "bower_components/purescript-${drv.name}";
    in ''
    if [ ! -e ${target} ]; then
      echo "Installing ${target}."
      mkdir -p ${target}
      cp --no-preserve=mode,ownership,timestamp -r ${toString drv.outPath}/* ${target}
    else
      echo "${target} already exists. Skipping."
    fi
  '';

  mkBowerStyleShellHook = drvs: toString (map mkBowerStyleCopyHook drvs);

  mkInstallBowerStyle = nixpkgs: packages:
    let packageDrvs = builtins.attrValues packages.inputs;
    in nixpkgs.stdenv.mkDerivation({
      name = "install-bower-style";
      buildInputs = packageDrvs;
      shellHook = mkBowerStyleShellHook packageDrvs;
  });
}
