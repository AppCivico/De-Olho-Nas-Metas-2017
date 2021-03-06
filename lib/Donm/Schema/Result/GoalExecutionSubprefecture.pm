use utf8;
package Donm::Schema::Result::GoalExecutionSubprefecture;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::GoalExecutionSubprefecture

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

=head1 TABLE: C<goal_execution_subprefecture>

=cut

__PACKAGE__->table("goal_execution_subprefecture");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'goal_execution_subprefecture_id_seq'

=head2 goal_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 subprefecture_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 period

  data_type: 'integer'
  is_nullable: 0

=head2 value

  data_type: 'text'
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
    sequence          => "goal_execution_subprefecture_id_seq",
  },
  "goal_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "subprefecture_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "period",
  { data_type => "integer", is_nullable => 0 },
  "value",
  { data_type => "text", is_nullable => 0 },
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

=head2 C<goal_execution_subprefecture_subprefecture_id_goal_id_perio_key>

=over 4

=item * L</subprefecture_id>

=item * L</goal_id>

=item * L</period>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "goal_execution_subprefecture_subprefecture_id_goal_id_perio_key",
  ["subprefecture_id", "goal_id", "period"],
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

=head2 subprefecture

Type: belongs_to

Related object: L<Donm::Schema::Result::Subprefecture>

=cut

__PACKAGE__->belongs_to(
  "subprefecture",
  "Donm::Schema::Result::Subprefecture",
  { id => "subprefecture_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-08-17 14:16:13
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1KdDLBvhaePzLpij+MX2EQ

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

    if ($value =~ m{^(\-?[0-9]+)$}) { return $value }
    elsif ($value =~ m{^([0-9]+,[0-9]+)$}) {
        $value =~ s/,/./g;
        return $value;
    }
    return undef;
}

sub get_projection_as_number {
    my ($self) = @_;

    my $projection = $self->result_source->schema->resultset('GoalExecutionSubprefecture')->search(
        {
            'me.goal_id'          => $self->get_column('goal_id'),
            'me.subprefecture_id' => $self->get_column('subprefecture_id'),
            'me.period'           => 10,
        }
    )->next;

    return undef unless ref $projection;

    return $self->goal->get_projection_as_number($projection->get_column('value'));
}

sub get_progress {
    my $self = shift;

    # Projeção.
    my $projection = $self->get_projection_as_number() or return undef; ## no critic

    # Valor.
    my $value = $self->get_value_as_number() or return undef;

    $projection ||= 1; # Avoid divison by zero.
    return sprintf('%.2f', ( ($value * 100) / $projection ));
}

__PACKAGE__->meta->make_immutable;

1;
