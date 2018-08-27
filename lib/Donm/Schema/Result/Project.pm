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

=head2 description

  data_type: 'text'
  is_nullable: 0

=head2 expected_results

  data_type: 'text'
  is_nullable: 1

=head2 current_scenario

  data_type: 'text'
  is_nullable: 1

=head2 updated_at

  data_type: 'timestamp'
  is_nullable: 1

=head2 budget_own_resources_investment

  data_type: 'text'
  is_nullable: 1

=head2 budget_own_resources_costing

  data_type: 'text'
  is_nullable: 1

=head2 budget_other_resources_investment

  data_type: 'text'
  is_nullable: 1

=head2 budget_other_resources_costing

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "title",
  { data_type => "text", is_nullable => 0 },
  "slug",
  { data_type => "text", is_nullable => 0 },
  "description",
  { data_type => "text", is_nullable => 0 },
  "expected_results",
  { data_type => "text", is_nullable => 1 },
  "current_scenario",
  { data_type => "text", is_nullable => 1 },
  "updated_at",
  { data_type => "timestamp", is_nullable => 1 },
  "budget_own_resources_investment",
  { data_type => "text", is_nullable => 1 },
  "budget_own_resources_costing",
  { data_type => "text", is_nullable => 1 },
  "budget_other_resources_investment",
  { data_type => "text", is_nullable => 1 },
  "budget_other_resources_costing",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 action_lines

Type: has_many

Related object: L<Donm::Schema::Result::ActionLine>

=cut

__PACKAGE__->has_many(
  "action_lines",
  "Donm::Schema::Result::ActionLine",
  { "foreign.project_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

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

=head2 project_badges

Type: has_many

Related object: L<Donm::Schema::Result::ProjectBadge>

=cut

__PACKAGE__->has_many(
  "project_badges",
  "Donm::Schema::Result::ProjectBadge",
  { "foreign.project_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-08-27 15:20:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:McMfQMfAeXRsdQf2UwpxRw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
