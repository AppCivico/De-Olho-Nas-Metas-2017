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

=head2 C<goal_execution_goal_id_period_key>

=over 4

=item * L</goal_id>

=item * L</period>

=back

=cut

__PACKAGE__->add_unique_constraint("goal_execution_goal_id_period_key", ["goal_id", "period"]);

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


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-08-16 14:47:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/iWGBruHjb1j+9iODqEX6g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
