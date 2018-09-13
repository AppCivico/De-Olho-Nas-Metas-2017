package Donm::Schema::ResultSet::GoalExecution;
use common::sense;
use Moose;
use namespace::autoclean;

extends "DBIx::Class::ResultSet";

sub search_for_accumulated {
    my $self = shift;

    return $self->search(
        {
            'me.accumulated' => 'true',
        }
    );
}

1;
