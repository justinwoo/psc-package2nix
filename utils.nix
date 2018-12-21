rec {
  wrapQuote = str: ''"${str}"'';

  getGlobsQuoted = packages: builtins.map wrapQuote (getGlobs packages);

  getGlobs = packages:
    let
      mkGlob = drv: ".psc-package/${packages.set}/${drv.name}/${drv.version}/src/**/*.purs";
      globs = builtins.map mkGlob (builtins.attrValues packages.inputs);
    in globs;

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

  mkCompilePscPackages = {
    mkDerivation ? (import <nixpkgs> {}).stdenv.mkDerivation,
    packages,
    purs,
    src ? ''"src/**/*.purs"'',
  }:
  let globs = builtins.toString (getGlobsQuoted packages);
  in mkDerivation {
    name = "compile";
    buildInputs = [purs];
    shellHook = "purs compile ${globs} ${src}";
  };

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
