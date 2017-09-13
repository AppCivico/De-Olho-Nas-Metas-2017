package Donm::Controller::API::Topic;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";

__PACKAGE__->config(
    # AutoBase.
    result => "DB::Topic",
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('topic') : CaptureArgs(0) { }

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ($self, $c) = @_;

    return $self->status_ok(
        $c,
        entity => {
            topic => [
                map {
                    my $r = $_;
                    +{ map { $_ => $r->get_column($_) } qw/id name/ }
                } $c->stash->{collection}->all()
            ]
        },
    );
}

__PACKAGE__->meta->make_immutable;

1;
