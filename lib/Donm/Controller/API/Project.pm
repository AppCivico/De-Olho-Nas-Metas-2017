package Donm::Controller::API::Project;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";
with "CatalystX::Eta::Controller::AutoResultGET";

__PACKAGE__->config(
    # AutoBase.
    result => "DB::Project",

    # AutoResultGET.
    object_key => "project",
    build_row  => sub {
        my ($project, $self, $c) = @_;

        my %unique_topics = ();
        my %unique_subprefectures = ();

        return {
            project => {
                ( map { $_ => $project->get_column($_) } qw/ id title slug description / ),

                current_scenario => $project->get_column('current_scenario'),
                expected_results => $project->get_column('expected_results'),

                (
                    budget => {
                        own_resources => {
                            investment => $project->get_column('budget_own_resources_investment'),
                            costing    => $project->get_column('budget_own_resources_costing'),
                        },
                        other_resources => {
                            investment => $project->get_column('budget_other_resources_investment'),
                            costing    => $project->get_column('budget_other_resources_costing'),
                        },
                        total => $project->get_total_planned_budget(),
                    },
                ),

                (
                    topics => [
                        map {
                            my $gp = $_;
                            +{ map {  $_ => $gp->goal->topic->get_column($_) } qw/ id name slug / }
                        }
                        grep {
                            # Hack para remover os eixos duplicados, pois um projeto pode estar atrelado à várias
                            # metas, e consequentemente a diversos eixos.
                            !( $unique_topics{$_->goal->topic->id}++ );
                        } $project->goal_projects->all()
                    ],
                ),

                (
                    goals => [
                        map {
                            my $gp = $_;

                            +{ map { $_ => $gp->goal->get_column($_) } qw / id title topic_id slug / }

                        } $project->goal_projects->all()
                    ],
                ),

                (
                    action_lines => [
                        map {
                            +{
                                id                    => $_->get_exhibition_id(),
                                title                 => $_->get_column("title"),
                                slug                  => $_->get_column("slug"),
                                achievement           => $_->get_column("achievement"),
                                indicator_description => $_->get_column("indicator_description"),
                            }
                        } $project->action_lines->all(),
                    ],
                ),

                (
                    subprefectures => [
                        map {
                            my $action_line = $_;
                            map {
                                +{
                                    id      => $_->subprefecture->get_column('id'),
                                    acronym => $_->subprefecture->get_column('acronym'),
                                    name    => $_->subprefecture->get_column('name'),
                                    slug    => $_->subprefecture->get_column('slug'),
                                }
                            }
                            grep {
                                # Removendo subprefeituras duplicadas.
                                !( $unique_subprefectures{$_->subprefecture->id}++ );
                            } $action_line->subprefecture_action_lines->all();
                        } $project->action_lines->all()
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
                        } $project->project_badges->all()
                    ],
                ),

                (
                    additional_information => [
                        map {
                            +{
                                description => $_->get_column('description'),
                                inserted_at => $_->get_column('inserted_at'),
                            }
                        } $project->project_additional_informations->all()
                    ],
                ),

                budget_execution => {
                    overall_total => $project->get_overall_total(),

                    per_year => [
                        map {
                            +{
                                year => $_->get_column('year'),
                                own_resources_investment   => $_->get_column('own_resources_investment'),
                                own_resources_costing      => $_->get_column('own_resources_costing'),
                                own_resources_total        => $_->get_column('own_resources_total'),
                                other_resources_investment => $_->get_column('other_resources_investment'),
                                other_resources_costing    => $_->get_column('other_resources_costing'),
                                other_resources_total      => $_->get_column('other_resources_total'),
                                total_year_investment      => $_->get_column('total_year_investment'),
                                total_year_costing         => $_->get_column('total_year_costing'),
                                total_year_total           => $_->get_column('total_year_total'),
                            }
                        } $project->project_budget_executions->all()
                    ],
                },

                (
                    secretariats => [
                        map {
                            +{
                                id   => $_->secretariat->get_column('id'),
                                name => $_->secretariat->get_column('name'),
                            }
                        } $project->project_secretariats->all()
                    ],
                )
            },
        };
    },
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('project') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ($self, $c, $project_id) = @_;

    my $project_rs = $c->stash->{collection}->search(
        {},
        {
            prefetch => [
                { 'action_lines'  => { 'subprefecture_action_lines' => 'subprefecture' } },
                { 'goal_projects' => { 'goal' => 'topic' } },
                { 'project_secretariats' => 'secretariat' },
            ],
        },
    );

    if ( !( $c->stash->{project} = $project_rs->search( { 'me.id' => $project_id } )->next() ) ) {
        $c->detach("/error_404");
    }
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ($self, $c) = @_;

    return $self->status_ok(
        $c,
        entity => {
            projects => [
                map {
                    my $r = $_;
                    my %unique_topics = ();
                    +{
                        ( map { $_ => $r->{$_} } qw/ id title slug description / ),

                        topics => [
                            map { $_->{goal}->{topic} }
                              grep { !($unique_topics{$_->{goal}->{topic_id}}++) } @{ $r->{goal_projects} }
                        ],

                        secretariats => [
                            map {
                                +{
                                    id   => $_->{secretariat}->{id},
                                    name => $_->{secretariat}->{name},
                                }
                            } @{ $r->{project_secretariats } }
                        ],

                        badges => [
                            map {
                                +{
                                    id   => $_->{badge}->{id},
                                    name => $_->{badge}->{name},
                                }
                            } @{ $r->{project_badges } }
                        ],
                    };
                } $c->stash->{collection}->search(
                    {
                        # Busca pelo titulo do projeto.
                        (
                            exists $c->req->params->{title}
                            ? ( 'me.title' => { ilike => '%' . $c->req->params->{title} . '%' } )
                            : ()
                        ),

                        # Busca por topicos.
                        (
                            exists $c->req->params->{topic_name}
                            ? (
                                '-and' => [
                                    \[ <<'SQL_QUERY', $c->req->params->{topic_name} ]
EXISTS (
    SELECT 1
    FROM goal_project
    JOIN goal
      ON goal_project.goal_id = goal.id
    JOIN topic
      ON goal.topic_id = topic.id
    WHERE goal_project.project_id = me.id
      and topic.name ILIKE ?
)
SQL_QUERY
                                ],
                            )
                            : ()
                        ),
                    },
                    {
                        prefetch => [
                            { 'project_badges' => 'badge' },
                            { 'goal_projects' => { 'goal' => 'topic' } },
                            { 'project_secretariats' => 'secretariat' },
                        ],
                        result_class => "DBIx::Class::ResultClass::HashRefInflator",
                    },
                )->all()
            ],
        },
    );
}

sub result : Chained('object') : PathPart('') : Args(0) : ActionClass('REST') { }

sub result_GET { }

__PACKAGE__->meta->make_immutable;

1;
