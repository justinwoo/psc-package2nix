default:
	nix-shell --run 'make build'
build:
	psc-package2nix
	./install-deps.nix
	purs compile 'src/**/*.purs' '.psc-package/*/*/*/src/**/*.purs'
