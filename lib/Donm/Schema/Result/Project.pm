use utf8;
package Donm::Schema::Result::Project;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::Project

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

=head1 TABLE: C<project>

=cut

__PACKAGE__->table("project");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 title

  data_type: 'text'
  is_nullable: 0

=head2 slug

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "title",
  { data_type => "text", is_nullable => 0 },
  "slug",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 goal_projects

Type: has_many

Related object: L<Donm::Schema::Result::GoalProject>

=cut

__PACKAGE__->has_many(
  "goal_projects",
  "Donm::Schema::Result::GoalProject",
  { "foreign.project_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_action_lines

Type: has_many

Related object: L<Donm::Schema::Result::ProjectActionLine>

=cut

__PACKAGE__->has_many(
  "project_action_lines",
  "Donm::Schema::Result::ProjectActionLine",
  { "foreign.project_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-10-03 12:07:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sqSSaWyn10EFp9ThwhPRnw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
