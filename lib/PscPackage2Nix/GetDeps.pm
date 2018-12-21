package PscPackage2Nix::GetDeps;

use warnings;
use strict;
use feature qw(say);

sub getDepsInner {
    my ($name, $json, $visited) = @_;
    chomp($name);

    if ($visited->{$name}) {
        return;
    }

    $visited->{$name} = 1;
    my @transitive_deps = `jq '.${name}.dependencies | values[]' $json`;
    foreach my $target (@transitive_deps) {
        getDepsInner($target, $json, $visited);
    }

    return;
}

sub getDeps {
    my ($config, $json) = @_;

    my @direct_deps = `jq '.depends | values[]' $config`;
    my %visited = ();

    foreach my $target (@direct_deps) {
        getDepsInner($target, $json, \%visited);
    }

    my @deps = sort keys %visited;

    return @deps;
}

1;
