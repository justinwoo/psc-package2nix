rec {
  mkCopyHook = packages: drv:
  let target = ".psc-package/${packages.set}/${drv.name}/${drv.version}/src";
  in ''
    if [ ! -e ${target} ]; then
    mkdir -p ${target}
    cp -p --no-preserve=mode,ownership -r ${toString drv.outPath}/src ${target}
    fi

    DRV_OUTPUT=${toString drv.outPath}/output
    if [ -e $DRV_OUTPUT ]; then
      mkdir -p output
      cp -p --no-preserve=mode,ownership -r $DRV_OUTPUT/* output
    fi
  '';

  mkDefaultShellHook = packages: drvs: toString (map (mkCopyHook packages) drvs);
}
