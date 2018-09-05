package Donm::Controller::Download;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

use Text::CSV;
use File::Temp ':seekable';

has csv => (
    is      => 'rw',
    isa     => 'Text::CSV',
    lazy    => 1,
    builder => '_build_csv',
);

sub root : Chained('/') : PathPart('') : CaptureArgs(0) {
    my ($self, $c) = @_;

    $c->response->headers->header(charset => "utf-8");
}

sub base : Chained('root') : PathPart('download') : CaptureArgs(0) {}

sub get_temp_file {
    my $fh = File::Temp->new( UNLINK => 0, SUFFIX => '.csv', DIR => '/tmp' );
    #binmode $fh, ':encoding(UTF-8)';

    return $fh;
}

sub _build_csv {
    return Text::CSV->new({
        binary       => 1,
        eol          => "\n",
        escape_char  => '"',
        quote_char   => '"',
        sep_char     => ",",
        always_quote => 1,
        auto_diag    => 1,
    });
}

__PACKAGE__->meta->make_immutable;

1;
