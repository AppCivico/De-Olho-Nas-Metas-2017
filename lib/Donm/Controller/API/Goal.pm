package Donm::Controller::API::Goal;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";

__PACKAGE__->config(
    # AutoBase.
    result => "DB::Goal",
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('goal') : CaptureArgs(0) { }

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ($self, $c) = @_;

    #return $self->status_ok(
    #    $c,
    #    entity => {
    #        goals => [
    #            map {
    #                my $r = $_;

    #                (
    #                    (
    #                        +{ map { $_ => $r->get_column($_) } qw/id title/ }
    #                    ),
    #                    (
    #                        projects => [ map {   ]
    #                    ),
    #                )
    #            } $c->stash->{collection}->search( {}, { prefetch => [ "goal_projects" ] }->all()
    #        ]
    #    },
    #);

    return $self->status_ok(
        $c,
        entity => [ $c->stash->{collection}->search( {}, { prefetch => "goal_projects", result_class => "DBIx::Class::ResultClass::HashRefInflator" } )->all ],
    );
}

__PACKAGE__->meta->make_immutable;

1;
