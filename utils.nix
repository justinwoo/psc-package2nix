{
  wrapQuote = import ./nix/wrapQuote.nix;

  # related to handling of globs of psc-package style deps
  getGlobsQuoted = import ./nix/getGlobsQuoted.nix;
  getGlobs = import ./nix/getGlobs.nix;

  # make a copy hook for psc-package style deps
  mkCopyHook = import ./nix/mkCopyHook.nix;

  # make a default shell hook that will copy psc-package style dependencies
  mkDefaultShellHook = import ./nix/mkDefaultShellHook.nix;

  # make a shell derivation that will install psc-package style dependencies
  mkInstallPackages = import ./nix/mkInstallPackages.nix;

  # make a shell derivation that will compile psc-package style dependencies
  mkCompilePscPackages = import ./nix/mkCompilePscPackages.nix;

  # make a copy hook for bower style deps
  mkBowerStyleCopyHook = import ./nix/mkBowerStyleCopyHook.nix;

  # make a default shell hook that will copy bower style dependencies
  mkBowerStyleShellHook = import ./nix/mkBowerStyleShellHook.nix;

  # make a shell derivation that will install bower style depeendencies
  mkInstallBowerStyle = import ./nix/mkInstallBowerStyle.nix;
}
