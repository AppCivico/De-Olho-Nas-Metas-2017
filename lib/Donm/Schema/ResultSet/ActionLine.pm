package Donm::Schema::ResultSet::ActionLine;
use common::sense;
use Moose;
use namespace::autoclean;

extends "DBIx::Class::ResultSet";

sub search_by_exhibition_id {
    my ($self, $exhibition_id) = @_;

    my ($project_id, $id_reference) = split m{\.}, $exhibition_id;

    return $self->search(
        {
            'me.project_id'   => $project_id,
            'me.id_reference' => $id_reference,
        }
    );
}

1;
