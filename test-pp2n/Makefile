default:
	nix-shell --run 'make pp2n'

pp2n:
	pp2n
	pp2n help
	pp2n psc-package2nix
	pp2n psc-package2nix # can be run twice
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
	pp2n test
	pp2n test -m Test.Main
	pp2n bundle
	test -f index.js
	pp2n bundle -m Main -o crap.js
	test -f crap.js
	node crap.js
