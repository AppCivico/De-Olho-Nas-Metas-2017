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

use DDP;

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

sub get_progress {
    my $self = shift;

    # Projeção.
    my $projection = $self->goal->get_column('projection_second_biennium');

    # Normalizando os dados de acordo com a projeção.
    ($projection) = split m{\n}, $projection;
    defined $projection or return undef;
    $projection =~ s/^\s+|\s+$//g;

    my $goal_id = $self->goal->id;

    if (grep { $goal_id == $_ } qw(45 47 51 52 19 20 3 6 34 7 38) ) {
        return undef; ## no critic
    }
    elsif ($projection =~ m{^[0-9]+(\.[0-9]+)?$}) { }
    elsif ($projection =~ m{^[0-9]+(,[0-9]+)?%$}) {
        $projection =~ s/,/./g;
        $projection =~ s/%//g;
    }
    elsif ($projection =~ m{^([0-9]+)\s+mil$}) {
        $projection = $1;
        $projection *= 1000;
    }
    elsif ($projection =~ m{^\Q-112.000 toneladas\E$}) { return undef }
    elsif ($projection =~ m{^([0-9]+(,[0-9]+)?)\Q mortes/ 100.000 habitantes\E$}) {
        $projection = $1;
        $projection =~ s/,/./g;
    }
    elsif ($projection =~ m{\QCOM RECURSOS DE OUTROS ENTES: \E([0-9]+(\.[0-9]+)?);}) {
        $projection = $1;
        $projection =~ s/\.//g;
    }
    elsif ($projection =~ m{^([0-9]+) dias$}) {
        $projection = $1;
    }
    elsif ($projection =~ m{^[0-9,]+%\Q (R$ \E([0-9\.,]+) per capita\)$}) { return undef }
    elsif ($projection =~ m{^-[0-9]+% \(R\$ ([0-9]+)\Q milhões mais correção monetária)\E}) {
        $projection = $1;
    }
    elsif ($projection =~ m{^([0-9]+(,[0-9]+)?)$}) {
        $projection =~ s/,/./;
    }
    elsif ($projection =~ m{^([0-9]+) ações$}) {
        $projection = $1;
    }
    elsif ($projection =~ m{^([0-9]+(,[0-9]+)?) em 1(00)?\.000$}) {
        $projection = $1;
        $projection =~ s/,/./;
    }
    elsif ($projection =~ m{^([0-9\.]+,[0-9]+)$}) {
        $projection =~ s/\.//g;
        $projection =~ s/,/./g;
    }
    elsif ($projection =~ m{^[0-9]+% \(([0-9\.]+)\);$}) {
        $projection = $1;
        $projection =~ s/\.//g;
    }
    elsif ($projection =~ m{^([0-9]+(,[0-9]+)?) km² \(}) {
        $projection = $1;
        $projection =~ s/,/./g;
    }
    elsif ($projection =~ m{^A definir$}) { return undef }
    elsif ($projection =~ m{^(\d+) regionais$}) {
        $projection = $1;
    }
    elsif ($projection =~ m{^R\$ ([0-9\.]+)\*?$}) {
        $projection = $1;
        $projection =~ s/\.//g;
    }
    else { return undef } ## no critic

    # Valor base.
    my $base_value = $self->goal->get_column('base_value') or return undef; ## no critic

    # Valor.
    my $value = $self->get_column('value');
    $value =~ s/^\s+|\s+$//g;

    if ($projection >= $base_value) {
        my $projection_base_diff = $projection - $base_value;
        my $value_base_diff      = $value - $base_value;

        $projection_base_diff ||= 1; # Avoid illegal division by zero.

        return sprintf('%.2f', ( ( $value_base_diff * 100 ) / $projection_base_diff ));
    }
    else {
        my $projection_base_diff = $base_value - $projection;
        my $value_base_diff = $value - $projection;

        $projection_base_diff ||= 1; # Avoid illegal division by zero.
        return sprintf('%.2f', ( 100 - ( ( $value_base_diff * 100 ) / $projection_base_diff ) ));
    }

    return undef; ## no critic
}

__PACKAGE__->meta->make_immutable;

1;

