use utf8;
package Donm::Schema::Result::ActionLine;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::ActionLine

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

=head1 TABLE: C<action_line>

=cut

__PACKAGE__->table("action_line");

=head1 ACCESSORS

=head2 project_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_reference

  data_type: 'integer'
  is_nullable: 1

=head2 title

  data_type: 'text'
  is_nullable: 1

=head2 indicator_description

  data_type: 'text'
  is_nullable: 1

=head2 achievement

  data_type: 'text'
  is_nullable: 1

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'action_line_id_seq'

=head2 slug

  data_type: 'text'
  is_nullable: 0

=head2 updated_at

  data_type: 'timestamp'
  is_nullable: 1

=head2 indicator

  data_type: 'text'
  is_nullable: 1

=head2 status

  data_type: 'text'
  is_nullable: 1

=head2 last_updated_at

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "project_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_reference",
  { data_type => "integer", is_nullable => 1 },
  "title",
  { data_type => "text", is_nullable => 1 },
  "indicator_description",
  { data_type => "text", is_nullable => 1 },
  "achievement",
  { data_type => "text", is_nullable => 1 },
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "action_line_id_seq",
  },
  "slug",
  { data_type => "text", is_nullable => 0 },
  "updated_at",
  { data_type => "timestamp", is_nullable => 1 },
  "indicator",
  { data_type => "text", is_nullable => 1 },
  "status",
  { data_type => "text", is_nullable => 1 },
  "last_updated_at",
  { data_type => "timestamp", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<action_line_id_reference_project_id_key>

=over 4

=item * L</id_reference>

=item * L</project_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "action_line_id_reference_project_id_key",
  ["id_reference", "project_id"],
);

=head2 C<action_line_slug_key>

=over 4

=item * L</slug>

=back

=cut

__PACKAGE__->add_unique_constraint("action_line_slug_key", ["slug"]);

=head1 RELATIONS

=head2 action_line_executions

Type: has_many

Related object: L<Donm::Schema::Result::ActionLineExecution>

=cut

__PACKAGE__->has_many(
  "action_line_executions",
  "Donm::Schema::Result::ActionLineExecution",
  {
    "foreign.action_line_id_reference" => "self.id_reference",
    "foreign.action_line_project_id"   => "self.project_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
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

=head2 subprefecture_action_lines

Type: has_many

Related object: L<Donm::Schema::Result::SubprefectureActionLine>

=cut

__PACKAGE__->has_many(
  "subprefecture_action_lines",
  "Donm::Schema::Result::SubprefectureActionLine",
  { "foreign.action_line_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-08-28 10:38:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:UvXXH3ZwudjiJEH/ZjiQ1A

sub get_exhibition_id {
    my $self = shift;

    return $self->get_column('project_id') . "." . $self->get_column('id_reference');
}

# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
