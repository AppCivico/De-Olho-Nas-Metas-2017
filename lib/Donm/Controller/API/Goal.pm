package Donm::Controller::API::Goal;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";
with "CatalystX::Eta::Controller::AutoResultGET";
with "CatalystX::Eta::Controller::TypesValidation";

__PACKAGE__->config(
    # AutoBase.
    result => "DB::Goal",

    # AutoResultGET.
    object_key => "goal",
    build_row  => sub {
        my ($goal, $self, $c) = @_;

        return {
            goal => {
                ( map { $_ => $goal->$_ } qw / id title topic_id first_biennium second_biennium slug / ),

                (
                    topic => { map { $_ => $goal->topic->$_ } qw/ id name slug / }
                ),
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
        { prefetch => [ "topic" ] },
    );

    if ( !( $c->stash->{goal} = $goal_rs->search( { 'me.id' => $goal_id } )->next ) ) {
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
                        ( map { $_ => $r->{$_} } qw/ id title topic_id topic slug / ),

                        topic => +{ map { $_ => $r->{topic}->{$_} } qw/ id name slug / },

                        goal_projects => [
                            map {
                                my $gp = $_;
                                +{
                                    ( map { $_ => $gp->{$_} } qw/ id goal_id project_id / ),

                                    project => +{ map { $_ => $gp->{project}->{$_} } qw/ id title slug / },
                                }
                            } @{ $r->{goal_projects} }
                        ],
                    }
                } $c->stash->{collection}->search(
                    {
                        (
                            exists($c->req->params->{topic_name})
                            ? ( 'topic.name' => { ilike => $c->req->params->{topic_name} } )
                            : ()
                        ),
                        (
                            exists($c->req->params->{title})
                            ? ( 'me.title' => { ilike => '%' . $c->req->params->{title} . '%' } )
                            : ()
                        ),
                    },
                    {
                        prefetch     => [ "topic", { 'goal_projects' => "project" } ],
                        order_by     => [ "me.id" ],
                        result_class => "DBIx::Class::ResultClass::HashRefInflator",
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
