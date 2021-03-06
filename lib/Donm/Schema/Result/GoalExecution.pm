use utf8;
package Donm::Schema::Result::GoalExecution;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::GoalExecution

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "PassphraseColumn");

=head1 TABLE: C<goal_execution>

=cut

__PACKAGE__->table("goal_execution");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'goal_execution_id_seq'

=head2 goal_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 period

  data_type: 'integer'
  is_nullable: 0

=head2 value

  data_type: 'text'
  is_nullable: 0

=head2 accumulated

  data_type: 'boolean'
  is_nullable: 0

=head2 updated_at

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "goal_execution_id_seq",
  },
  "goal_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "period",
  { data_type => "integer", is_nullable => 0 },
  "value",
  { data_type => "text", is_nullable => 0 },
  "accumulated",
  { data_type => "boolean", is_nullable => 0 },
  "updated_at",
  { data_type => "timestamp", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<goal_execution_goal_id_period_accumulated_key>

=over 4

=item * L</goal_id>

=item * L</period>

=item * L</accumulated>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "goal_execution_goal_id_period_accumulated_key",
  ["goal_id", "period", "accumulated"],
);

=head1 RELATIONS

=head2 goal

Type: belongs_to

Related object: L<Donm::Schema::Result::Goal>

=cut

__PACKAGE__->belongs_to(
  "goal",
  "Donm::Schema::Result::Goal",
  { id => "goal_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-08-17 14:16:13
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3MZsYuOFdtaL+tb5+sMsYw

sub get_year {
    my $self = shift;

    my $period = $self->get_column('period');

    if    ($period =~ m{^[12]$}) { return 2017 }
    elsif ($period =~ m{^[34]$}) { return 2018 }
    elsif ($period =~ m{^[56]$}) { return 2019 }
    elsif ($period =~ m{^[78]$}) { return 2020 }

    return undef; ## no critic
}

sub get_semester {
    my $self = shift;

    my $period = $self->get_column('period');

    if    ($period =~ m{^[1357]$}) { return 1 }
    elsif ($period =~ m{^[2468]$}) { return 2 }

    return undef; ## no critic
}

sub get_value_as_number {
    my $self = shift;

    my $value = $self->get_column('value');
    $value =~ s/^\s+|\s+$//g;
    return undef unless length $value > 0;

    if ($value =~ m{^(\-?[0-9]+(\.[0-9]+)?)$}) { return $value }
    elsif ($value =~ m{^([0-9]+,[0-9]+)$}) {
        $value =~ s/,/./g;
        return $value;
    }
    return undef;
}

sub get_progress {
    my ($self) = @_;

    die "I should not calculate progress of non-accumulated executions."
      if !$self->get_column('accumulated');

    my $progress = $self->get_raw_progress();

    my $goal_execution_rs = $self->goal->goal_executions;

    my $period = $self->get_column('period');
    my $is_all_goal_executions_accumulated = $self->goal->is_all_goal_executions_accumulated();

    my $has_previous_execution_rs = $goal_execution_rs->search(
        {
            'me.period'      => { '<', $period },
            'me.accumulated' => 'true',
        },
        {
            order_by => [
                { '-desc' => 'me.period' },
                \'(CASE WHEN me.accumulated THEN 1 ELSE 2 END) ASC',
            ]
        }
    );

    if ($period == 1 || $has_previous_execution_rs->count == 0) {
        return $progress;
    }

    my $last_accumulatead_goal_execution = $has_previous_execution_rs->next();

    if (ref $last_accumulatead_goal_execution) {
        my $last_accumulatead_goal_execution_progress = $last_accumulatead_goal_execution->get_raw_progress();

        #use DDP; p [ $period, $progress, $last_accumulatead_goal_execution_progress];

        if (defined $last_accumulatead_goal_execution_progress) {
            return sprintf('%.2f', ( $progress - $last_accumulatead_goal_execution_progress ));
        }
    }

    return undef; ## no critic
}

sub get_raw_progress {
    my $self = shift;

    # Projeção.
    my $projection = $self->goal->get_projection_as_number() or return undef; ## no critic

    # Valor base.
    my $base_value = $self->goal->get_column('base_value') or return undef; ## no critic
    if ($base_value =~ m{^N/?A$}) {
        return undef;
    }

    # Valor.
    my $value = $self->get_value_as_number() or return undef;

    # Progresso.
    my $projection_base_diff = $projection - $base_value;
    $projection_base_diff ||= 1; # Avoid illegal division by zero.

    my $progress = sprintf('%.2f', ( ( ($value - $base_value) * 100 ) / $projection_base_diff ));
    if ($progress == 0) {
        return 0;
    }
    return $progress;
}

__PACKAGE__->meta->make_immutable;

1;

