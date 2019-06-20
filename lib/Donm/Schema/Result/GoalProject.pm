use utf8;
package Donm::Schema::Result::GoalProject;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::GoalProject

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

=head1 TABLE: C<goal_project>

=cut

__PACKAGE__->table("goal_project");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'goal_project_id_seq'

=head2 goal_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 project_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 created_at

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 0
  original: {default_value => \"now()"}

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
    sequence          => "goal_project_id_seq",
  },
  "goal_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "project_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "created_at",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 0,
    original      => { default_value => \"now()" },
  },
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

=head2 C<goal_project_goal_id_project_id_key>

=over 4

=item * L</goal_id>

=item * L</project_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "goal_project_goal_id_project_id_key",
  ["goal_id", "project_id"],
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

=head2 project

Type: belongs_to

Related object: L<Donm::Schema::Result::Project>

=cut

__PACKAGE__->belongs_to(
  "project",
  "Donm::Schema::Result::Project",
  { id => "project_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-08-24 17:26:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:huBWGojuowodshFSwhUoEg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
