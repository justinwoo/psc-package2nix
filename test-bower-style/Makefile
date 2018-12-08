default: build

build: purs-deps npm-deps bower-deps
	npm run pulp-build

purs-deps:
	nix-shell install-deps.nix --run "echo installation complete"

npm-deps:
	npm install

bower-deps:
	npm run bower-install

clean:
	rm -rf bower_components
	rm -rf output

nix:
	nix-shell --run make
