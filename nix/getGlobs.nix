packages:

let
  mkGlob = drv: ".psc-package/${packages.set}/${drv.name}/${drv.version}/src/**/*.purs";
  globs = builtins.map mkGlob (builtins.attrValues packages.inputs);
in globs
