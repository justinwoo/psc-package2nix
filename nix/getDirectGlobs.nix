packages:

let
  mkGlob = drv: "${drv.outPath}/src/**/*.purs";
  globs = builtins.map mkGlob (builtins.attrValues packages.inputs);
in globs
