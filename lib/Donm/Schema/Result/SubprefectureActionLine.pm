use utf8;
package Donm::Schema::Result::SubprefectureActionLine;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::SubprefectureActionLine

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

=head1 TABLE: C<subprefecture_action_line>

=cut

__PACKAGE__->table("subprefecture_action_line");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'subprefecture_action_line_id_seq'

=head2 subprefecture_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 action_line_id

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
    sequence          => "subprefecture_action_line_id_seq",
  },
  "subprefecture_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "action_line_id",
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
  { id => "action_line_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-10-19 18:22:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3XNlCMJYQTTsPlo9cRCQ7Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
