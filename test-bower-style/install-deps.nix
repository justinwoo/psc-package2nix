let
  pkgs = import <nixpkgs> {};
  packages = import ./packages.nix { inherit pkgs; };
  pp2n-utils = import ../utils.nix;

in pp2n-utils.mkInstallBowerStyle {
  inherit packages;
}
