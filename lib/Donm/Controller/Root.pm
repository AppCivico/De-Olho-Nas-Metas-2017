package Donm::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

__PACKAGE__->config(namespace => '');

sub default :Path {
    my ( $self, $c ) = @_;

    return $c->detach("/error_404");
}

sub error_404 : Private {
    my ($self, $c) = @_;

    return $self->status_not_found($c, message => "Endpoint not found.");
}

__PACKAGE__->meta->make_immutable;

1;
