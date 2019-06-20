package Donm::Controller::Download::Projects;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Donm::Controller::Download' }

use File::Temp ':seekable';

sub root : Chained('/download/base') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('projects') : CaptureArgs(0) { }

sub download : Chained('base') : PathPart('') : Args(0) {
    my ($self, $c) = @_;

    my $fh = $self->get_temp_file();

    $self->csv->print(
        $fh,
        [
            qw( ID NOME DESCRIÇÃO ),
            'RESULTADOS ESPERADOS',
            'SITUAÇÃO ENCONTRADA',
            qw(
                ORÇAMENTO_INVESTIMENTO_RECURSOS_PROPRIOS
                ORÇAMENTO_INVESTIMENTO_OUTROS_RECURSOS
                ORÇAMENTO_CUSTEIO_RECURSOS_PRÓPRIOS
                ORÇAMENTO_CUSTEIO_OUTROS_RECURSOS
            )
        ]
    );

    my $project_rs = $c->model('DB::Project')->search(
        undef,
        { order_by => [qw( me.id )] },
    );
    while (my $project = $project_rs->next()) {
        $self->csv->print(
            $fh,
            [
                $project->get_column('id'),
                $project->get_column('title'),
                $project->get_column('description'),
                $project->get_column('expected_results'),
                $project->get_column('current_scenario'),
                $project->get_column('budget_own_resources_investment'),
                $project->get_column('budget_other_resources_investment'),
                $project->get_column('budget_own_resources_costing'),
                $project->get_column('budget_other_resources_costing'),
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
