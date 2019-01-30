# This file was generated by Psc-Package2Nix
# You will not want to edit this file.
# To change the contents of this file, first fork Psc-Package2Nix
# And edit the $file_template

{ pkgs ? import <nixpkgs> {} }:

let
  inputs = {

    "aff" = pkgs.stdenv.mkDerivation {
      name = "aff";
      version = "v5.0.2";
      src = pkgs.fetchgit {
        url = "https://github.com/slamdata/purescript-aff.git";
        rev = "v5.0.2";
        sha256 = "0jhqaimcg9cglnby0rn5xnrllcjj9mlb5yp6zqpy8b9zpg744v7d";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "arrays" = pkgs.stdenv.mkDerivation {
      name = "arrays";
      version = "v5.1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-arrays.git";
        rev = "v5.1.0";
        sha256 = "1pcvkgfp8kxk7s1lm28cpc24d0y782n6n6xirkdb09jjh6i62r6s";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "assert" = pkgs.stdenv.mkDerivation {
      name = "assert";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-assert.git";
        rev = "v4.0.0";
        sha256 = "1bg60rx1r2kc41vzpp420v5gnl6njgqna4h6qcyr3zh1rrzj965l";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "bifunctors" = pkgs.stdenv.mkDerivation {
      name = "bifunctors";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-bifunctors.git";
        rev = "v4.0.0";
        sha256 = "1bdra5fbkraglqrrm484vw8h0wwk48kzkn586v4y7fg106q1q386";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "console" = pkgs.stdenv.mkDerivation {
      name = "console";
      version = "v4.2.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-console.git";
        rev = "v4.2.0";
        sha256 = "1b2nykdq1dzaqyra5pi8cvvz4dsbbkg57a2c88yi931ynm19nnw6";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "const" = pkgs.stdenv.mkDerivation {
      name = "const";
      version = "v4.1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-const.git";
        rev = "v4.1.0";
        sha256 = "0qbd2aisax52yw6sybdhs7na943cbsd6mylhhgsamrf7hzh6v51p";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "contravariant" = pkgs.stdenv.mkDerivation {
      name = "contravariant";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-contravariant.git";
        rev = "v4.0.0";
        sha256 = "0vvcgfclx236kg4y76nwih787wyqacq8mmx42q64xzl964yrwxkk";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "control" = pkgs.stdenv.mkDerivation {
      name = "control";
      version = "v4.1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-control.git";
        rev = "v4.1.0";
        sha256 = "10703zvsnjm5fc74k6wzjsvpsfyc3jci3jxhm7rxf7ymya9z1z53";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "datetime" = pkgs.stdenv.mkDerivation {
      name = "datetime";
      version = "v4.1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-datetime.git";
        rev = "v4.1.0";
        sha256 = "1r998l57p8q5sj74kdb3hdhd3asb596ipgjqhyz2i2v4yiazfriv";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "distributive" = pkgs.stdenv.mkDerivation {
      name = "distributive";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-distributive.git";
        rev = "v4.0.0";
        sha256 = "0zbn0yq1vv7fbbf1lncg80irz0vg7wnw9b9wrzxhdzpbkw4jinsl";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "effect" = pkgs.stdenv.mkDerivation {
      name = "effect";
      version = "v2.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-effect.git";
        rev = "v2.0.0";
        sha256 = "0l46xqz39khf2c779d8mvax1fp2phy5sf8qdn31x67dz389mjr81";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "either" = pkgs.stdenv.mkDerivation {
      name = "either";
      version = "v4.1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-either.git";
        rev = "v4.1.0";
        sha256 = "0h37aynl96lyfg02szfrl298mnlqrjb95g4mrpd233mqj2zj2487";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "enums" = pkgs.stdenv.mkDerivation {
      name = "enums";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-enums.git";
        rev = "v4.0.0";
        sha256 = "1g2zns5xsdb9xyv14iwyvg2x39hjpsyvvrkh8gy1pqgzv6frmb18";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "exceptions" = pkgs.stdenv.mkDerivation {
      name = "exceptions";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-exceptions.git";
        rev = "v4.0.0";
        sha256 = "17s0rg9k4phivhx9j3l2vqqfdhk61gpj1xfqy8w6zj3rnxj0b2cv";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "foldable-traversable" = pkgs.stdenv.mkDerivation {
      name = "foldable-traversable";
      version = "v4.1.1";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-foldable-traversable.git";
        rev = "v4.1.1";
        sha256 = "03x89xcmphckzjlp4chc7swrpw347ll5bvr2yp7x9v2jqw2jlyi1";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "functions" = pkgs.stdenv.mkDerivation {
      name = "functions";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-functions.git";
        rev = "v4.0.0";
        sha256 = "0675k5kxxwdvsjs6a3is8pwm3hmv0vbcza1b8ls10gymmfz3k3hj";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "functors" = pkgs.stdenv.mkDerivation {
      name = "functors";
      version = "v3.1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-functors.git";
        rev = "v3.1.0";
        sha256 = "1hdvsznzwl8akkgy0islr48qrqhr3syagggily27lv0d1mjl0rw3";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "gen" = pkgs.stdenv.mkDerivation {
      name = "gen";
      version = "v2.1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-gen.git";
        rev = "v2.1.0";
        sha256 = "0ddsfb6a23rahkw9d3ymp2sf6d6vxndj73y61cdv74zrlr2nx74p";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "globals" = pkgs.stdenv.mkDerivation {
      name = "globals";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-globals.git";
        rev = "v4.0.0";
        sha256 = "150mc0kv0cb5fkx0szicwczjr54bglmlyaynj2grf1r4gnjg967s";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "identity" = pkgs.stdenv.mkDerivation {
      name = "identity";
      version = "v4.1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-identity.git";
        rev = "v4.1.0";
        sha256 = "1scdgbfkphfmapw7p9rnsiynpmqzyvnal2glzj450q51f8g1dhld";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "integers" = pkgs.stdenv.mkDerivation {
      name = "integers";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-integers.git";
        rev = "v4.0.0";
        sha256 = "17d4bfpnrmbxlc7hhhrvnli70ydaqyr26zgvc9q52a76zgdcb4cf";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "invariant" = pkgs.stdenv.mkDerivation {
      name = "invariant";
      version = "v4.1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-invariant.git";
        rev = "v4.1.0";
        sha256 = "1fimpbh3yb7clvqxcdf4yf9im64z0v2s9pbspfacgq5b4vshjas9";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "lazy" = pkgs.stdenv.mkDerivation {
      name = "lazy";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-lazy.git";
        rev = "v4.0.0";
        sha256 = "156q89l4nvvn14imbhp6xvvm82q7kqh1pyndmldmnkhiqyr84vqv";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "lists" = pkgs.stdenv.mkDerivation {
      name = "lists";
      version = "v5.3.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-lists.git";
        rev = "v5.3.0";
        sha256 = "14z4pmw76h3rj6mqwkxny91nqrk5rj5drsl4za2sng83bkj9fj4k";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "math" = pkgs.stdenv.mkDerivation {
      name = "math";
      version = "v2.1.1";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-math.git";
        rev = "v2.1.1";
        sha256 = "1msmy9w7y6fij62sdc55w68gpwkhm6lhgc8qjisjk4sxx1wdg1rr";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "maybe" = pkgs.stdenv.mkDerivation {
      name = "maybe";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-maybe.git";
        rev = "v4.0.0";
        sha256 = "06mm4a6lbp5by14vms3lyhqp64211lwnq1dqbaazvdp0afykx1z5";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "newtype" = pkgs.stdenv.mkDerivation {
      name = "newtype";
      version = "v3.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-newtype.git";
        rev = "v3.0.0";
        sha256 = "0qvk9p41miy806b05b4ikbr3if0fcyc35gfrwd2mflcxxp46011c";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "nonempty" = pkgs.stdenv.mkDerivation {
      name = "nonempty";
      version = "v5.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-nonempty.git";
        rev = "v5.0.0";
        sha256 = "1vz174sg32cqrp52nwb2vz9frrzmdwzzlgl4vc2cm5wlf2anirxj";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "ordered-collections" = pkgs.stdenv.mkDerivation {
      name = "ordered-collections";
      version = "v1.4.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-ordered-collections.git";
        rev = "v1.4.0";
        sha256 = "0kh1hxs5lqmdzjf8zs7i8val9l5z67l7g10rgbnkln2j54mym3cf";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "orders" = pkgs.stdenv.mkDerivation {
      name = "orders";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-orders.git";
        rev = "v4.0.0";
        sha256 = "13p1sm4dxkmxhld9x5qqg62iiajjb3qpzs66c1r24y5fs4zsfry4";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "parallel" = pkgs.stdenv.mkDerivation {
      name = "parallel";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-parallel.git";
        rev = "v4.0.0";
        sha256 = "1d5bnagabw2k8yxywkygwrpblb2ggqh2fhpqfrx2sj1y53x332hg";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "partial" = pkgs.stdenv.mkDerivation {
      name = "partial";
      version = "v2.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-partial.git";
        rev = "v2.0.0";
        sha256 = "0nw5989ydin2d12b97ch4pdynxkq91xpj7yym5gpd5fpbgy36mdi";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "prelude" = pkgs.stdenv.mkDerivation {
      name = "prelude";
      version = "v4.1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-prelude.git";
        rev = "v4.1.0";
        sha256 = "1pwqhsba4xyywfflma5rfqzqac1vmybwq7p3wkm4wsackvbn34h5";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "refs" = pkgs.stdenv.mkDerivation {
      name = "refs";
      version = "v4.1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-refs.git";
        rev = "v4.1.0";
        sha256 = "08161iy1xbafzblv033v84156azpcqkiw9v9d6gliphrq5fm17gm";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "st" = pkgs.stdenv.mkDerivation {
      name = "st";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-st.git";
        rev = "v4.0.0";
        sha256 = "0m2jkb9dmpbr8s1c20l7sm2q11y5rx8gqfiyspnyhq5apzkknjr0";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "tailrec" = pkgs.stdenv.mkDerivation {
      name = "tailrec";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-tailrec.git";
        rev = "v4.0.0";
        sha256 = "0z7k80nl8dgv8mc2w8xsl2n0637bd1l8ppxak8kaifgjjwa81hx3";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "transformers" = pkgs.stdenv.mkDerivation {
      name = "transformers";
      version = "v4.1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-transformers.git";
        rev = "v4.1.0";
        sha256 = "1aazy1zk66lng8w0gjx2l7sqfr968gmibdxi4kd93zb7bw5vldvn";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "tuples" = pkgs.stdenv.mkDerivation {
      name = "tuples";
      version = "v5.1.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-tuples.git";
        rev = "v5.1.0";
        sha256 = "045nsy0r2g51gih0wjhcvhl6gfr8947mlrqwg644ygz72rjm8wq4";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "type-equality" = pkgs.stdenv.mkDerivation {
      name = "type-equality";
      version = "v3.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-type-equality.git";
        rev = "v3.0.0";
        sha256 = "1b7szyca5s96gaawvgwrw7fa8r7gqsdff7xhz3vvngnylv2scl3w";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "unfoldable" = pkgs.stdenv.mkDerivation {
      name = "unfoldable";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-unfoldable.git";
        rev = "v4.0.0";
        sha256 = "077vl30j3pxr3zw6cw7wd0vi22j92j8va15r26rn53wzbzcgr41j";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };

    "unsafe-coerce" = pkgs.stdenv.mkDerivation {
      name = "unsafe-coerce";
      version = "v4.0.0";
      src = pkgs.fetchgit {
        url = "https://github.com/purescript/purescript-unsafe-coerce.git";
        rev = "v4.0.0";
        sha256 = "0k9255mk2mz6xjb11pwkgfcblmmyvr86ig5kr92jwy95xim09zip";
      };
      phases = "installPhase";
      installPhase = "ln -s $src $out";
    };
};

in {
  inherit inputs;

  set = "30112018";
  source = "https://github.com/justinwoo/spacchetti.git";
}
