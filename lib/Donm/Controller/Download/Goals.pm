package Donm::Controller::Download::Goals;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Donm::Controller::Download' }

use File::Temp ':seekable';

sub root : Chained('/download/base') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('goals') : CaptureArgs(0) { }

sub download : Chained('base') : PathPart('') : Args(0) {
    my ($self, $c) = @_;

    my $fh = $self->get_temp_file();

    $self->csv->print(
        $fh,
        [
            qw( ID NOME EIXO SECRETARIA PROJEÇÃO INDICADOR ),
            'VALOR BASE', 'STATUS',
        ]
    );

    my $goal_rs = $c->model('DB::Goal')->search(
        undef,
        { prefetch => [ qw/ secretariat topic / ] },
    );

    while (my $goal = $goal_rs->next()) {
        $self->csv->print(
            $fh,
            [
                $goal->get_column('id'),
                $goal->get_column('title'),
                (
                    ref $goal->topic
                    ? $goal->topic->get_column('name')
                    : undef
                ),
                (
                    ref $goal->secretariat
                    ? $goal->secretariat->get_column('name')
                    : undef
                ),
                $goal->get_column('projection_second_biennium'),
                $goal->get_column('indicator_description'),
                $goal->get_column('base_value'),
                $goal->get_column('status'),
            ]
        );
    }

    my $filename = 'Metas_' . DateTime->now->ymd('') . '.csv';
    $c->response->headers->header( 'content-disposition' => "attachment;filename=$filename");

    binmode $fh, ':raw';
    $fh->seek(0, SEEK_SET);
    $c->res->body($fh);
    $c->detach();
}

__PACKAGE__->meta->make_immutable;

1;
