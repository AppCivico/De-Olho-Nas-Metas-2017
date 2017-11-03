package Donm::Controller::API::Topic;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";
with "CatalystX::Eta::Controller::AutoObject";
with "CatalystX::Eta::Controller::AutoResultGET";

use DDP;

__PACKAGE__->config(
    # AutoBase.
    result => "DB::Topic",

    # AutoObject.
    object_verify_type => "int",
    object_key => "topic",

    build_row => sub {
        my ($topic, $self, $c) = @_;

        return {
            topic => {
                id   => $topic->get_column('id'),
                name => $topic->get_column('name'),
                slug => $topic->get_column('slug'),

                goals => [
                    map {
                        +{
                            id    => $_->get_column('id'),
                            title => $_->get_column('title'),
                            slug  => $_->get_column('slug'),
                        }
                    } $topic->goals->all()
                ],
            }
        };
    },
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('topic') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ($self, $c, $id) = @_;

    $c->stash->{collection} = $c->stash->{collection}->search(
        {},
        { prefetch => [ qw/ goals / ] },
    );
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ($self, $c) = @_;

    return $self->status_ok(
        $c,
        entity => {
            topics => [
                map {
                    +{
                        id   => $_->get_column('id'),
                        name => $_->get_column('name'),
                        slug => $_->get_column('slug'),
                    }
                } $c->stash->{collection}->all()
            ]
        },
    );
}

sub result : Chained('object') : PathPart('') : Args(0) : ActionClass('REST') { }

sub result_GET { }

__PACKAGE__->meta->make_immutable;

1;
