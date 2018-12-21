packages:
drv:

let
  target = ".psc-package/${packages.set}/${drv.name}/${drv.version}";
in ''
  if [ ! -e ${target} ]; then
    echo "Installing ${target}."
    mkdir -p ${target}
    cp --no-preserve=mode,ownership,timestamp -r ${toString drv.outPath}/* ${target}
  else
    echo "${target} already exists. Skipping."
  fi
''
