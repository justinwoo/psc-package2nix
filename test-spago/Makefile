default:
	nix-shell --run 'make pp2n'

pp2n:
	spago psc-package-insdhall
	pp2n psc-package2nix
	pp2n install
	pp2n build
