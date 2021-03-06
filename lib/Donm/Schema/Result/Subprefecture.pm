use utf8;
package Donm::Schema::Result::Subprefecture;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::Subprefecture

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

=head1 TABLE: C<subprefecture>

=cut

__PACKAGE__->table("subprefecture");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'subprefecture_id_seq'

=head2 acronym

  data_type: 'text'
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 latitude

  data_type: 'text'
  is_nullable: 1

=head2 longitude

  data_type: 'text'
  is_nullable: 1

=head2 timestamp

  data_type: 'timestamp'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 site

  data_type: 'text'
  is_nullable: 1

=head2 email

  data_type: 'text'
  is_nullable: 1

=head2 telephone

  data_type: 'text'
  is_nullable: 1

=head2 address

  data_type: 'text'
  is_nullable: 1

=head2 slug

  data_type: 'text'
  is_nullable: 0

=head2 deputy_mayor

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "subprefecture_id_seq",
  },
  "acronym",
  { data_type => "text", is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "latitude",
  { data_type => "text", is_nullable => 1 },
  "longitude",
  { data_type => "text", is_nullable => 1 },
  "timestamp",
  {
    data_type     => "timestamp",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "site",
  { data_type => "text", is_nullable => 1 },
  "email",
  { data_type => "text", is_nullable => 1 },
  "telephone",
  { data_type => "text", is_nullable => 1 },
  "address",
  { data_type => "text", is_nullable => 1 },
  "slug",
  { data_type => "text", is_nullable => 0 },
  "deputy_mayor",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 action_line_execution_subprefectures

Type: has_many

Related object: L<Donm::Schema::Result::ActionLineExecutionSubprefecture>

=cut

__PACKAGE__->has_many(
  "action_line_execution_subprefectures",
  "Donm::Schema::Result::ActionLineExecutionSubprefecture",
  { "foreign.subprefecture_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 goal_execution_subprefectures

Type: has_many

Related object: L<Donm::Schema::Result::GoalExecutionSubprefecture>

=cut

__PACKAGE__->has_many(
  "goal_execution_subprefectures",
  "Donm::Schema::Result::GoalExecutionSubprefecture",
  { "foreign.subprefecture_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 regions

Type: has_many

Related object: L<Donm::Schema::Result::Region>

=cut

__PACKAGE__->has_many(
  "regions",
  "Donm::Schema::Result::Region",
  { "foreign.subprefecture_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 subprefecture_action_lines

Type: has_many

Related object: L<Donm::Schema::Result::SubprefectureActionLine>

=cut

__PACKAGE__->has_many(
  "subprefecture_action_lines",
  "Donm::Schema::Result::SubprefectureActionLine",
  { "foreign.subprefecture_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-08-28 10:56:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0phQeaPjNroq7DiVhJ+SzA

sub get_action_lines_count {
    my ($self) = @_;

    return $self->subprefecture_action_lines->count();
}

__PACKAGE__->meta->make_immutable;
1;
