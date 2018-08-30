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

sub get_progress {
    my $self = shift;

    my $projection = $self->result_source->schema->resultset('ActionLineExecution')->search(
        {
            'me.action_line_project_id'   => $self->get_column('action_line_project_id'),
            'me.action_line_id_reference' => $self->get_column('action_line_id_reference'),
            'me.period' => 9,
        }
    )->next;
    return undef unless ref $projection;

    use DDP; p $projection->get_column('value');

    return undef;
}

__PACKAGE__->meta->make_immutable;

1;
