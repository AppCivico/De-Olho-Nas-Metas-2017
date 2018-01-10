use utf8;
package Donm::Schema::Result::Region;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::Region

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

=head1 TABLE: C<region>

=cut

__PACKAGE__->table("region");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 geom

  data_type: 'geometry'
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 lat

  data_type: 'text'
  is_nullable: 1

=head2 long

  data_type: 'text'
  is_nullable: 1

=head2 subprefecture_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 slug

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "geom",
  { data_type => "geometry", is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 1 },
  "lat",
  { data_type => "text", is_nullable => 1 },
  "long",
  { data_type => "text", is_nullable => 1 },
  "subprefecture_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
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

=head2 region_indicators

Type: has_many

Related object: L<Donm::Schema::Result::RegionIndicator>

=cut

__PACKAGE__->has_many(
  "region_indicators",
  "Donm::Schema::Result::RegionIndicator",
  { "foreign.region_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 region_variables

Type: has_many

Related object: L<Donm::Schema::Result::RegionVariable>

=cut

__PACKAGE__->has_many(
  "region_variables",
  "Donm::Schema::Result::RegionVariable",
  { "foreign.region_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 subprefecture

Type: belongs_to

Related object: L<Donm::Schema::Result::Subprefecture>

=cut

__PACKAGE__->belongs_to(
  "subprefecture",
  "Donm::Schema::Result::Subprefecture",
  { id => "subprefecture_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-01-04 18:14:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kR3uOg1csnEpFWMahrAK4g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
