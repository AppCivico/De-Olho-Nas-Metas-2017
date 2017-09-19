use utf8;
package Donm::Schema::Result::ProjectActionLine;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::ProjectActionLine

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

=head1 TABLE: C<project_action_line>

=cut

__PACKAGE__->table("project_action_line");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'project_action_line_id_seq'

=head2 project_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 action_line_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 action_line_subid

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "project_action_line_id_seq",
  },
  "project_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "action_line_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "action_line_subid",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 action_line

Type: belongs_to

Related object: L<Donm::Schema::Result::ActionLine>

=cut

__PACKAGE__->belongs_to(
  "action_line",
  "Donm::Schema::Result::ActionLine",
  { id => "action_line_id", subid => "action_line_subid" },
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


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-09-19 17:34:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4xtyCEjSmx9NTVHQjaAQog


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
