# Psc-Package2Nix

[![Build Status](https://travis-ci.com/justinwoo/psc-package2nix.svg?branch=master)](https://travis-ci.com/justinwoo/psc-package2nix)

A tool to generate a Nix expression from Psc-Package configuration. *You could also probably use Spago by using `spago psc-package-insdhall`.* Works by prefetching Git SHAs of the dependencies you depend on.

Read the blog post about this project here: <https://qiita.com/kimagure/items/85a64437f9af78398638>. There's also a post about this whole setup (going from Bower): <https://qiita.com/kimagure/items/aec640d0047d08d2ce90>.

I (Justin) gave a talk about Psc-Package2Nix in the Helsinki Haskell meetup a while ago: <https://speakerdeck.com/justinwoo/nix-ify-your-psc-package-dependencies>. The talk is a little bit out of date but the core ideas are the same.

## Show me the code!

See [test-build](./test-build). However, this will in many ways not be what you want for development, so you might end up with using `pp2n install; pp2n build` in development.

## Usage example

First, you should include psc-package2nix in some way. One way to do this would be to use my [Easy-PureScript-Nix](https://github.com/justinwoo/easy-purescript-nix) derivations, but otherwise you could use this repository directly as a source.

```nix
{ pkgs ? import <nixpkgs> {} }:

let
  pp2n = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "psc-package2nix";
    rev = "cc48ccd64862366a44b4185a79de321f93755782";
    sha256 = "0cvd1v3d376jiwh4rfhlyijxw3j6jp9rkm9hdb7k7sjxqs1dsviv";
  }) { inherit pkgs; };

  easy-ps = import (pkgs.fetchFromGitHub {
    owner = "justinwoo";
    repo = "easy-purescript-nix";
    rev = "5d8808480436f178ccdc6593744cb6ca642cbb6c";
    sha256 = "0r80d4dmagvkgm44rpjszl84xwgcwdbks2x9inad7akcpmkc8nnh";
  });

in pkgs.stdenv.mkDerivation {
  name = "pp2n-test-shell";
  buildInputs = [pp2n easy-ps.purs];
}
```

In a project where you have a `psc-package.json` file, you should now be able to run `pp2n psc-package2nix`:

```json
{
  "name": "pp2n-test",
  "set": "psc-0.12.3",
  "source": "https://github.com/purescript/package-sets.git",
  "depends": [
    "prelude"
  ]
}
```

```
> pp2n psc-package2nix
/nix/store/vcxj8hd3xjsqlpv45d0cwb44lz5h4zby-package-sets
built package set to .psc-package/psc-0.12.3/.set
fetching .psc-package2nix/prelude-v4.1.0
wrote packages.nix
```

Note that the package set is built by `nix-build` to the package set location (see package-sets README for more explanation). The hashes for all dependencies (including transitive dependencies in the package set) are then solved for and their hashes are stored as flat files in `.psc-package2nix/` for usage in generating `packages.nix`.

With the `packages.nix` generated, now you can install your dependencies into your nix store and have them automatically copied to `.psc-package` under the correct psc-package directories. This you can accomplish with the various setsups in the test directories. And while you can edit `packages.nix` to your liking, you will find that the problem comes up that Psc-Package will not know how to find new packages, because it uses the package set file to resolve that information. You could try to use `pp2n` in place of Psc-Package for most operations you need, but it's still likely that you will instead want to provide for the package set file being available. If you truly must edit the contents of your package set often, you might consider combining this tool with Spago's psc-package insdhall tools.

But really, you can do almost anything you want with this. You might mix and match some various parts of what is here to fit your own needs.

## Project development workflow with pp2n

By default, `pp2n` will install dependencies in a way that Psc-Package can also use.

```
> pp2n install
Installing .psc-package/psc-0.12.3/prelude/v4.1.0.
```

Now you can build either using `pp2n build` or using plain old `psc-package build`.

```
> pp2n build
Compiling Data.Symbol
Compiling Record.Unsafe
...
```

See the example repo here: <https://github.com/justinwoo/pp2n-test>

## More Information

If you need more information on how Psc-Package works, you might see the Package-Sets README: <https://github.com/purescript/package-sets>

## Complaints

PRs welcome
