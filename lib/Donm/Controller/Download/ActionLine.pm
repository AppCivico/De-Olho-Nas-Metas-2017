package Donm::Controller::Download::ActionLine;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Donm::Controller::Download' }

use File::Temp ':seekable';

sub root : Chained('/download/base') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('action-lines') : CaptureArgs(0) { }

sub download : Chained('base') : PathPart('') : Args(0) {
    my ($self, $c) = @_;

    my $fh = $self->get_temp_file();

    $self->csv->print(
        $fh,
        [
            qw(
                ID
                NOME
                STATUS
                PROJETO
                INDICADOR
                DESCRIÇÃO_INDICADOR
                OBJETIVO
            ),
        ]
    );

    my $action_line_rs = $c->model('DB::ActionLine')->search(
        undef,
        {
            prefetch => [qw( project )],
            order_by => [qw( me.project_id me.id_reference )],
        }
    );
    while (my $action_line = $action_line_rs->next()) {
        $self->csv->print(
            $fh,
            [
                $action_line->get_exhibition_id(),
                $action_line->get_column('title'),
                $action_line->get_column('status'),
                $action_line->project->get_column('title'),
                $action_line->get_column('indicator'),
                $action_line->get_column('indicator_description'),
                $action_line->get_column('achievement'),
            ]
        );
    }

    my $filename = 'Projetos_' . DateTime->now->ymd('') . '.csv';
    $c->response->headers->header('content-disposition' => "attachment;filename=$filename");

    binmode $fh, ':raw';
    $fh->seek(0, SEEK_SET);
    $c->res->body($fh);
    $c->detach();
}

__PACKAGE__->meta->make_immutable;

1;
