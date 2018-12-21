let
  wrapQuote = import ./wrapQuote.nix;
  getGlobs = import ./getGlobs.nix;
in packages: builtins.map wrapQuote (getGlobs packages)
