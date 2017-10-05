package Donm::Controller::API::Project;
use common::sense;
use Moose;
use namespace::autoclean;

use DDP;

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
        return {
            project => {
                ( map { $_ => $project->get_column($_) } qw/ id title slug description / ),

                (
                    topics => [
                        map {
                            my $gp = $_;

                            my $topic = $gp->goal->topic;
                            my $topic_id = $topic->id;

                            +{ map {  $_ => $topic->get_column($_) } qw/ id name slug / }
                        }
                        # Hack para remover os eixos duplicados, pois um projeto pode estar atrelado à várias metas, e
                        # consequentemente a diversos eixos.
                        grep { !$unique_topics{$_->goal->topic->id}++ } $project->goal_projects->all()
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
                            my $action_line  = $_->action_line;
                            my $action_line_id = $action_line->get_column('id') . "." . $action_line->get_column('subid');

                            +{
                                id    => $action_line_id,
                                title => $action_line->get_column('title'),
                            }
                        } $project->project_action_lines->all(),
                    ],
                ),
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
        { prefetch => [ { "goal_projects" => { "goal" => "topic" } }, { "project_action_lines" => "action_line" } ] },
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

                    # Um projeto possui várias metas. Essas várias metas possuem eixos. Para que os eixos não
                    # apareceram duplicados (quando se aplica), vou unificá-los numa hash.
                    my %topics = map {
                        $_->{goal}->{topic}->{id} => $_->{goal}->{topic}
                    } @{ $r->{goal_projects} };

                    +{
                        ( map { $_ => $r->{$_} } qw/ id title slug description / ),

                        ( topics => [ values %topics ] ),
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
                        prefetch => [ { 'goal_projects' => { 'goal' => "topic" } } ],
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
