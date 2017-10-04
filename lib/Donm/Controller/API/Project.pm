package Donm::Controller::API::Project;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";

__PACKAGE__->config(
    # AutoBase.
    result => "DB::Project",
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('project') : CaptureArgs(0) { }

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

__PACKAGE__->meta->make_immutable;

1;
