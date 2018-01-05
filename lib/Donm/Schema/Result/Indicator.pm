use utf8;
package Donm::Schema::Result::Indicator;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::Indicator

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

=head1 TABLE: C<indicator>

=cut

__PACKAGE__->table("indicator");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 explanation

  data_type: 'text'
  is_nullable: 0

=head2 formula

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "explanation",
  { data_type => "text", is_nullable => 0 },
  "formula",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<indicator_name_key>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("indicator_name_key", ["name"]);

=head1 RELATIONS

=head2 region_indicators

Type: has_many

Related object: L<Donm::Schema::Result::RegionIndicator>

=cut

__PACKAGE__->has_many(
  "region_indicators",
  "Donm::Schema::Result::RegionIndicator",
  { "foreign.indicator_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-01-04 18:14:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Sh8ACS4W7ZN7bkvPkqxxJQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
