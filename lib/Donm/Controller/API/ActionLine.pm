package Donm::Controller::API::ActionLine;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";
with "CatalystX::Eta::Controller::AutoListGET";
with "CatalystX::Eta::Controller::AutoResultGET";

use List::Util 'reduce';

__PACKAGE__->config(
    # AutoBase.
    result      => 'DB::ActionLine',
    result_attr => { order_by => [ qw/ me.project_id me.id_reference / ] },

    # AutoListGET.
    list_key => 'action_lines',
    build_list_row => sub {
        my ($r, $self, $c) = @_;

        return {
            id                    => $r->get_exhibition_id(),
            achievement           => $r->get_column('achievement'),
            title                 => $r->get_column('title'),
            indicator_description => $r->get_column('indicator_description'),
            slug                  => $r->get_column('slug'),
        };
    },

    object_key => 'action_line',
    build_row  => sub {
        my ($action_line, $self, $c) = @_;

        return {
            action_line => {
                id                    => $action_line->get_exhibition_id(),
                achievement           => $action_line->get_column('achievement'),
                title                 => $action_line->get_column('title'),
                indicator_description => $action_line->get_column('indicator_description'),
                slug                  => $action_line->get_column('slug'),
                indicator             => $action_line->get_column('indicator'),
                status                => $action_line->get_column('status'),
                last_updated_at       => $action_line->get_column('last_updated_at'),

                subprefectures => [
                    map {
                        +{
                            id        => $_->subprefecture->get_column('id'),
                            name      => $_->subprefecture->get_column('name'),
                            slug      => $_->subprefecture->get_column('slug'),
                            indicator => $_->get_column('indicator'),
                        };
                    } $action_line->subprefecture_action_lines->all()
                ],

                project => {
                    id          => $action_line->project->get_column('id'),
                    title       => $action_line->project->get_column('title'),
                    slug        => $action_line->project->get_column('slug'),
                    description => $action_line->project->get_column('description'),
                },

                executions => [
                    map {
                        +{
                            value       => $_->get_column('value'),
                            year        => $_->get_year(),
                            semester    => $_->get_semester(),
                            accumulated => $_->get_column('accumulated'),
                            progress    => $_->get_progress(),
                        }
                    } $action_line->action_line_executions->search({
                        'me.period'      => { '-in' => [1.. 8] },
                        # O correto aqui seria enviar o dado não acumulado. Por um bug na API do PlanejaSampa, os
                        # valores acumulados estão vindo com acumulado=false e os não acumulados com acumulado=true.
                        # Quando corrigem, precisamos voltar a flag para accumulated=false.
                        'me.accumulated' => 'true',
                        #'me.accumulated' => 'false',
                    })->all()
                ],

                execution_subprefectures => (
                    reduce {
                        my $subprefecture_id = $b->get_column('subprefecture_id');

                        $a ||= {};
                        $a->{$subprefecture_id}{subprefecture} ||= {
                            id      => $b->subprefecture->get_column('id'),
                            name    => $b->subprefecture->get_column('name'),
                            acronym => $b->subprefecture->get_column('acronym'),
                            slug    => $b->subprefecture->get_column('slug'),
                        };

                        $a->{$subprefecture_id}{total_progress} ||= $c->model('DB::ActionLineExecutionSubprefecture')->search(
                            {
                                'me.action_line_project_id'   => $b->get_column('action_line_project_id'),
                                'me.action_line_id_reference' => $b->get_column('action_line_id_reference'),
                                'me.subprefecture_id'         => $subprefecture_id,
                            }
                        )->get_total_progress();

                        $a->{$subprefecture_id}{projection} ||= $action_line->get_projection_by_subprefecture($subprefecture_id);

                        push @{ $a->{$subprefecture_id}{per_semester} }, {
                            year        => $b->get_year(),
                            semester    => $b->get_semester(),
                            value       => $b->get_column('value'),
                            progress    => $b->get_progress(),
                        };
                        $a;
                    } {},
                    $action_line->action_line_execution_subprefectures
                      ->filter_projection()
                      ->filter_accumulated()
                      ->search(
                          {},
                          {
                              prefetch => [qw( subprefecture )],
                              order_by => [qw( subprefecture_id )],
                          }
                        )
                      ->all()
                ),
            },
        },
    },
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('action-line') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ($self, $c, $exhibition_id) = @_;

    $c->stash->{collection} = $c->stash->{collection}->search(
        {},
        { prefetch => [ 'project', { 'subprefecture_action_lines' => 'subprefecture' } ] }
    );

    if ( !( $c->stash->{action_line} = $c->stash->{collection}->search_by_exhibition_id($exhibition_id)->next ) ) {
        $c->detach("/error_404");
    }
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET { }

sub result : Chained('object') : PathPart('') : Args(0) : ActionClass('REST') { }

sub result_GET { }

__PACKAGE__->meta->make_immutable;

1;
