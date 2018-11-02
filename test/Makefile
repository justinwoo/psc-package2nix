default:
	nix-shell --run 'make build'
build:
	psc-package2nix
	nix-shell install-deps.nix --run 'echo installation complete'
	psc-package build
