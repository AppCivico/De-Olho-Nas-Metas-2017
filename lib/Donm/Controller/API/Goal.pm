package Donm::Controller::API::Goal;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";
with "CatalystX::Eta::Controller::AutoResultGET";
with "CatalystX::Eta::Controller::TypesValidation";

use HTML::Entities;
use List::Util 'reduce';

__PACKAGE__->config(
    # AutoBase.
    result => "DB::Goal",

    # AutoResultGET.
    object_key => "goal",
    build_row  => sub {
        my ($goal, $self, $c) = @_;

        my $total_progress = $goal->get_total_progress();
        my $temporary_progress = $goal->temporary_progress;
        $temporary_progress   += 0 if defined $temporary_progress;

        my %unique_subprefectures = ();
        return {
            goal => {
                (
                    map { $_ => $goal->get_column($_) }
                    qw/ id title topic_id slug indicator_description last_updated_at status /
                ),

                #total_progress => $total_progress,
                total_progress => $temporary_progress,
                original_total_progress => $total_progress,
                time => time(),

                secretariats => [
                    (
                        ref $goal->secretariat
                        ? +{
                            id   => $goal->secretariat->get_column('id'),
                            name => $goal->secretariat->get_column('name'),
                        }
                        : ()
                    ),
                ],

                execution => [
                    #map {
                    #    +{
                    #        value       => $_->get_column('value'),
                    #        updated_at  => $_->get_column('updated_at'),
                    #        accumulated => $_->get_column('accumulated'),
                    #        year        => $_->get_year(),
                    #        semester    => $_->get_semester(),
                    #        progress    => $_->get_progress(),
                    #    };
                    #} $goal->goal_executions->search_for_accumulated()->all()
                ],

                execution_subprefectures => (
                    reduce {
                        my $subprefecture_id = $b->get_column('subprefecture_id');

                        $a->{$subprefecture_id}{subprefecture} ||= {
                            id      => $b->subprefecture->get_column('id'),
                            name    => $b->subprefecture->get_column('name'),
                            acronym => $b->subprefecture->get_column('acronym'),
                            slug    => $b->subprefecture->get_column('slug'),
                        };

                        $a->{$subprefecture_id}{total_progress} ||= $goal->goal_execution_subprefectures
                          ->search( { 'me.subprefecture_id' => $subprefecture_id } )
                          ->get_total_progress();

                        push @{ $a->{$subprefecture_id}{per_semester} }, {
                            year        => $b->get_year(),
                            semester    => $b->get_semester(),
                            value       => $b->get_column('value'),
                            progress    => $b->get_progress(),
                        };
                        $a;
                    } {},
                    $goal->goal_execution_subprefectures
                      ->filter_projection()
                      ->filter_accumulated()
                      ->search({}, { order_by => [qw( subprefecture_id )] })->all()
                ),

                projection_first_biennium  => $goal->get_readable_projection_first_biennium(),
                projection_second_biennium => $goal->get_readable_projection_second_biennium(),

                ( topics => [ +{ map { $_ => $goal->topic->$_ } qw/ id name slug / } ] ),

                (
                    subprefectures => [
                        map {
                            my $gp = $_;
                            map {
                                my $action_line = $_;
                                map {
                                    +{
                                        id      => $_->subprefecture->get_column('id'),
                                        acronym => $_->subprefecture->get_column('acronym'),
                                        name    => $_->subprefecture->get_column('name'),
                                        slug    => $_->subprefecture->get_column('slug'),
                                    }
                                } grep {
                                    # As metas possuem projetos, e estes projetos possuem diversas linhas de ação. Cada
                                    # linha de ação possui uma subprefeitura. Sendo assim, para que as subprefeituras
                                    # não venham duplicadas, dou um grep para unificá-las.
                                    !($unique_subprefectures{$_->subprefecture->id}++)
                                } $action_line->subprefecture_action_lines->all();
                            } $gp->project->action_lines->all()
                        } $goal->goal_projects->all()
                    ],
                ),

                (
                    projects => [
                        map {
                            my $gp = $_;
                            +{
                                project => +{ map { $_ => $gp->project->get_column($_) } qw/ id title slug description / },
                            }
                        } $goal->goal_projects->all()
                    ],
                ),

                (
                    badges => [
                        map {
                            my $badge = $_->badge;
                            +{
                                id   => $badge->get_column('id'),
                                name => $badge->get_column('name'),
                            }
                        } $goal->goal_badges->all()
                    ],
                ),

                (
                    additional_information => [
                        map {
                            my $ai = $_;
                            +{
                                description => decode_entities($ai->get_column('description')),
                                inserted_at => $ai->get_column('inserted_at'),
                            }
                        } $goal->goal_additional_informations->all()
                    ],
                )
            },
        };
    },
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('goal') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ($self, $c, $goal_id) = @_;

    $c->stash->{goal_id} = $goal_id;

    my $goal_rs = $c->stash->{collection}->search(
        {},
        {
            prefetch => [
                'topic',
                'goal_executions',
                'secretariat',
                { 'goal_execution_subprefectures' => 'subprefecture' },
                { 'goal_badges' => 'badge' },
                { 'goal_projects' => { 'project' => { 'action_lines' => { 'subprefecture_action_lines' => 'subprefecture' } } } },
            ],
        },
    );

    if ( !( $c->stash->{goal} = $goal_rs->search( { 'me.id' => $goal_id } )->next() ) ) {
        $c->detach("/error_404");
    }
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ($self, $c) = @_;

    $self->validate_request_params(
        $c,
        topic_name => {
            required => 0,
            type     => "Str",
        },
        title => {
            required => 0,
            type     => "Str",
        },
    );

    return $self->status_ok(
        $c,
        entity => {
            goals => [
                map {
                    my $r = $_;
                    +{
                        ( map { $_ => $r->{$_} } qw/ id title topic_id topic slug indicator_description / ),

                        secretariats => [
                            +{
                                id   => $r->{secretariat}->{id},
                                name => $r->{secretariat}->{name},
                            },
                        ],

                        topics => [ +{ map { $_ => $r->{topic}->{$_} } qw/ id name slug / } ],

                        projects => [
                            map {
                                my $gp = $_;

                                +{ map { $_ => $gp->{project}->{$_} } qw/ id title slug / }
                            } @{ $r->{goal_projects} }
                        ],
                        badges => [
                            map {
                                my $badge = $_->{badge};
                                +{
                                    id   => $badge->{id},
                                    name => $badge->{name},
                                }
                            } @{ $r->{goal_badges} }
                        ],
                    }
                } $c->stash->{collection}->search(
                    {
                        (
                            exists($c->req->params->{topic_name})
                            ? ( 'topic.name' => { ilike => '%' . $c->req->params->{topic_name} . '%' } )
                            : ()
                        ),
                        (
                            exists($c->req->params->{title})
                            ? ( 'me.title' => { ilike => '%' . $c->req->params->{title} . '%' } )
                            : ()
                        ),
                    },
                    {
                        prefetch     => [ 'topic', { 'goal_projects' => 'project' }, 'goal_executions', { 'goal_badges' => 'badge' }, 'secretariat' ],
                        order_by     => [ 'me.id' ],
                        result_class => 'DBIx::Class::ResultClass::HashRefInflator',
                    }
                )->all()
            ],
        },
    );
}

sub result : Chained('object') : PathPart('') : Args(0) : ActionClass('REST') { }

sub result_GET { }

__PACKAGE__->meta->make_immutable;

1;
