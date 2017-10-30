package Donm::Utils;
use common::sense;

use vars qw(@ISA @EXPORT);
use Text::Unaccent::PurePerl qw(unac_string);

@ISA    = qw/ Exporter /;
@EXPORT = qw/ slugify /;

sub slugify {
    my ($string) = @_;

    $string = unac_string($string);

    $string =~ s/[^a-z0-9]+/-/gi;
    $string = substr $string, 0, 80;
    $string =~ s/^-?(.+?)-?$/$1/;
    $string = lc($string);

    return $string;
}

1;

