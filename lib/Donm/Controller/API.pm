package Donm::Controller::API;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

sub root : Chained('/') : PathPart('api') : CaptureArgs(0) {
    my ($self, $c) = @_;

    $c->response->headers->header(charset => "utf-8");
}

sub forbidden : Private {
    my ($self, $c) = @_;

    $self->status_forbidden($c, message => "access denied");
    $c->detach();
}

__PACKAGE__->meta->make_immutable;

1;
