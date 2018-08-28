use utf8;
package Donm::Schema::Result::ActionLineExecutionSubprefecture;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::ActionLineExecutionSubprefecture

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

=head1 TABLE: C<action_line_execution_subprefecture>

=cut

__PACKAGE__->table("action_line_execution_subprefecture");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'action_line_execution_subprefecture_id_seq'

=head2 action_line_project_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 action_line_id_reference

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 subprefecture_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 value

  data_type: 'text'
  is_nullable: 0

=head2 period

  data_type: 'integer'
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
    sequence          => "action_line_execution_subprefecture_id_seq",
  },
  "action_line_project_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "action_line_id_reference",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "subprefecture_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "value",
  { data_type => "text", is_nullable => 0 },
  "period",
  { data_type => "integer", is_nullable => 0 },
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

=head2 C<action_line_execution_subpref_action_line_project_id_action_key>

=over 4

=item * L</action_line_project_id>

=item * L</action_line_id_reference>

=item * L</subprefecture_id>

=item * L</period>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "action_line_execution_subpref_action_line_project_id_action_key",
  [
    "action_line_project_id",
    "action_line_id_reference",
    "subprefecture_id",
    "period",
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


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-08-28 10:56:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Zf/8CPs3pubVy+OaIWNTvQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
