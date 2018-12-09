default:
	nix-shell --run 'make build'
build:
	psc-package2nix
	./install-deps.nix
	psc-package build
