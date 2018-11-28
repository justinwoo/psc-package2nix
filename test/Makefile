default:
	nix-shell --run 'make build'
build: clean
	psc-package2nix
	nix-shell install-deps.nix --run 'echo installation complete'
	psc-package build
build-precompile:
	psc-package2nix
	psc-package2nix-precompile
	nix-shell install-precompiles.nix --run 'echo installation complete'
	psc-package build
clean:
	rm -rf output
	rm -rf .psc-package
	rm -rf .psc-package2nix
