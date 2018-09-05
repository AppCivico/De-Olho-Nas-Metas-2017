use utf8;
package Donm::Schema::Result::ActionLineExecution;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::ActionLineExecution

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

=head1 TABLE: C<action_line_execution>

=cut

__PACKAGE__->table("action_line_execution");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'action_line_execution_id_seq'

=head2 action_line_project_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 action_line_id_reference

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 value

  data_type: 'text'
  is_nullable: 0

=head2 period

  data_type: 'integer'
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
    sequence          => "action_line_execution_id_seq",
  },
  "action_line_project_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "action_line_id_reference",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "value",
  { data_type => "text", is_nullable => 0 },
  "period",
  { data_type => "integer", is_nullable => 0 },
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

=head2 C<action_line_execution_action_line_project_id_action_line_id_key>

=over 4

=item * L</action_line_project_id>

=item * L</action_line_id_reference>

=item * L</period>

=item * L</accumulated>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "action_line_execution_action_line_project_id_action_line_id_key",
  [
    "action_line_project_id",
    "action_line_id_reference",
    "period",
    "accumulated",
  ],
);

=head1 RELATIONS

=head2 action_line

Type: belongs_to

Related object: L<Donm::Schema::Result::ActionLine>

=cut

__PACKAGE__->belongs_to(
  "action_line",
  "Donm::Schema::Result::ActionLine",
  {
    id_reference => "action_line_id_reference",
    project_id   => "action_line_project_id",
  },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-08-28 10:38:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:wD9y4XfyiAd0eYJTtNmZyQ

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

    if    ($value eq '')    { return undef }
    if    ($value eq '-')   { return undef }
    if    ($value eq 'ND')  { return undef }
    elsif ($value eq 'N/D') { return undef }
    elsif ($value =~ m{^\-?[0-9]+$})              { return $value }
    elsif ($value =~ m{^(\-?[0-9]+(\.[0-9]+)?)$}) { return $value }
    elsif ($value =~ m{^([0-9]+,[0-9]+)$}) {
        $value =~ s/,/./g;
        return $value;
    }

    return undef;
}

sub get_progress {
    my $self = shift;

    die "Cant calculate progress of an not accumulated action line execution."
      if !$self->get_column('accumulated');

    my $action_line_id = $self->action_line->get_exhibition_id();
    if (grep { $action_line_id == $_ } qw/ 1.5 7.5 12.4 22.1 29.1 30.1 30.3 30.5 30.6 58.1 58.2 69.5 2.2 6.6 12.3/ ) {
        return undef;
    }

    my $base_value = $self->action_line->get_base_value_as_number() or return undef; ## no critic
    my $projection = $self->action_line->get_projection_as_number() or return undef; ## no critic
    my $value      = $self->get_value_as_number()                   or return undef; ## no critic

    my $projection_base_diff = $projection - $base_value;
    $projection_base_diff ||= 1; # Avoid illegal division by zero.

    return sprintf('%.2f', ( ( ($value - $base_value) * 100 ) / $projection_base_diff ));
}

__PACKAGE__->meta->make_immutable;

1;
