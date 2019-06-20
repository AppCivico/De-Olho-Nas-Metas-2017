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

sub with_accumulated {
    my $self = shift;

    return $self->search(
        {},
        {
            '+columns' => [
                { accumulated => \'(me.period = 9)::boolean' }
            ]
        }
    );
}

sub filter_accumulated {
    my $self = shift;

    return $self->search(
        {
            'me.period' => { '!=' => 9 }
        }
    );
}

sub filter_projection {
    my $self = shift;

    return $self->search(
        {
            'me.period' => { '!=' => 10 }
        }
    );
}

sub get_total_progress {
    my $self = shift;

    if (ref (my $accumulated = $self->search( { 'me.period' => 9 } )->next)) {
        return $accumulated->get_progress();
    }
    return undef;
}

1;
