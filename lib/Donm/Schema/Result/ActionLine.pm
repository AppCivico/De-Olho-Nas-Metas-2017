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

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 subid

  data_type: 'integer'
  is_nullable: 0

=head2 title

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "subid",
  { data_type => "integer", is_nullable => 0 },
  "title",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=item * L</subid>

=back

=cut

__PACKAGE__->set_primary_key("id", "subid");

=head1 RELATIONS

=head2 project_action_lines

Type: has_many

Related object: L<Donm::Schema::Result::ProjectActionLine>

=cut

__PACKAGE__->has_many(
  "project_action_lines",
  "Donm::Schema::Result::ProjectActionLine",
  {
    "foreign.action_line_id"    => "self.id",
    "foreign.action_line_subid" => "self.subid",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-09-19 17:34:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:LMbR8NCXDXzOWXS4+TbLcQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
