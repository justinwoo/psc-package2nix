default:
	nix-shell pp2n.nix --run 'make pp2n'

pp2n:
	pp2n
	pp2n help
	pp2n sources
	pp2n install
	pp2n build
	pp2n build -g corefn
	test -f output/Main/index.js
	test -f output/Main/corefn.json
	rm -rf output/Prelude
	pp2n bower-install
	purs compile "bower_components/*/src/**/*.purs"
	test -f output/Prelude/index.js
