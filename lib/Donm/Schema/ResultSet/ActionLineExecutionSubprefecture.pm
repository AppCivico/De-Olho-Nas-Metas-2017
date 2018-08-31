package Donm::Schema::ResultSet::ActionLineExecutionSubprefecture;
use common::sense;
use Moose;
use namespace::autoclean;

extends "DBIx::Class::ResultSet";

# sub with_accumulated {
#     my $self = shift;

#     return $self->search(
#         {},
#         {
#             '+columns' => [
#                 { accumulated => \'(me.period = 9)::boolean' }
#             ]
#         }
#     );
# }

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

    #use DDP; p $self->search( { 'me.period' => 9 } )->next();

    if (ref (my $accumulated = $self->search( { 'me.period' => 9 } )->next)) {
        return $accumulated->get_progress();
    }
    return undef;
}

1;
