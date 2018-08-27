use utf8;
package Donm::Schema::Result::ProjectBudgetExecution;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::ProjectBudgetExecution

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

=head1 TABLE: C<project_budget_execution>

=cut

__PACKAGE__->table("project_budget_execution");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'project_budget_execution_id_seq'

=head2 project_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 year

  data_type: 'integer'
  is_nullable: 0

=head2 own_resources_investment

  data_type: 'text'
  is_nullable: 0

=head2 own_resources_costing

  data_type: 'text'
  is_nullable: 0

=head2 own_resources_total

  data_type: 'text'
  is_nullable: 0

=head2 other_resources_investment

  data_type: 'text'
  is_nullable: 0

=head2 other_resources_costing

  data_type: 'text'
  is_nullable: 0

=head2 other_resources_total

  data_type: 'text'
  is_nullable: 0

=head2 total_year_investment

  data_type: 'text'
  is_nullable: 0

=head2 total_year_costing

  data_type: 'text'
  is_nullable: 0

=head2 total_year_total

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
    sequence          => "project_budget_execution_id_seq",
  },
  "project_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "year",
  { data_type => "integer", is_nullable => 0 },
  "own_resources_investment",
  { data_type => "text", is_nullable => 0 },
  "own_resources_costing",
  { data_type => "text", is_nullable => 0 },
  "own_resources_total",
  { data_type => "text", is_nullable => 0 },
  "other_resources_investment",
  { data_type => "text", is_nullable => 0 },
  "other_resources_costing",
  { data_type => "text", is_nullable => 0 },
  "other_resources_total",
  { data_type => "text", is_nullable => 0 },
  "total_year_investment",
  { data_type => "text", is_nullable => 0 },
  "total_year_costing",
  { data_type => "text", is_nullable => 0 },
  "total_year_total",
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

=head2 C<project_budget_execution_project_id_year_key>

=over 4

=item * L</project_id>

=item * L</year>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "project_budget_execution_project_id_year_key",
  ["project_id", "year"],
);

=head1 RELATIONS

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


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-08-27 18:41:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GNT9dyfjLGQVJwUm1Bz8qw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
