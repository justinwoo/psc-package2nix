# Bower-Style

By using Psc-Package2Nix derivations, we can instead reroute the installation step to install bower-style packages, if you insist on wanting to use Bower. From the [utils](../utils.nix), we can use the `mkInstallBowerStyle` function:

```nix
let
  pkgs = import <nixpkgs> {};
  packages = import ./packages.nix {};
  pp2n-utils = import ../utils.nix;

in pp2n-utils.mkInstallBowerStyle pkgs packages
```

This will then generate the various `bower_components/purescript-${dependency}` packages.

Then you can install various packages from bower, either by `bower install --save [dependency]` or by adding to bower.json. This directory contains an example of a package being installed in addition in [bower.json](./bower.json):

```json
{
  "name": "test-bower-style",
  "ignore": [
    "**/.*",
    "node_modules",
    "bower_components",
    "output"
  ],
  "dependencies": {
    "purescript-mochi": "^0.1.0"
  },
  "devDependencies": {}
}
```
