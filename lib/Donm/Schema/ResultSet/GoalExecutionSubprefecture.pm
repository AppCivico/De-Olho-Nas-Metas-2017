package Donm::Schema::ResultSet::GoalExecutionSubprefecture;
use common::sense;
use Moose;
use namespace::autoclean;

extends "DBIx::Class::ResultSet";

sub search_only_not_accumulated {
    my $self = shift;

    return $self->search(
        {
            'me.period' => { '<=', '8' }
        }
    );
}

1;
