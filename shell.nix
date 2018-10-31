let
  pkgs = import <nixpkgs> {};
  default = import ./default.nix {};

in pkgs.stdenv.mkDerivation {
  name = "shell";
  src = ./.;
  buildInputs = [default];
}
