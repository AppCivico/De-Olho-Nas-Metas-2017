use utf8;
package Donm::Schema::Result::RegionIndicator;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::RegionIndicator

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

=head1 TABLE: C<region_indicator>

=cut

__PACKAGE__->table("region_indicator");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'region_indicator_id_seq'

=head2 region_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 indicator_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 value

  data_type: 'numeric'
  is_nullable: 0
  size: [8,2]

=head2 year

  data_type: 'integer'
  is_nullable: 0

=head2 sources

  data_type: 'text[]'
  is_nullable: 1

=head2 url_observatorio

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "region_indicator_id_seq",
  },
  "region_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "indicator_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "value",
  { data_type => "numeric", is_nullable => 0, size => [8, 2] },
  "year",
  { data_type => "integer", is_nullable => 0 },
  "sources",
  { data_type => "text[]", is_nullable => 1 },
  "url_observatorio",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<region_indicator_region_id_indicator_id_key>

=over 4

=item * L</region_id>

=item * L</indicator_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "region_indicator_region_id_indicator_id_key",
  ["region_id", "indicator_id"],
);

=head1 RELATIONS

=head2 indicator

Type: belongs_to

Related object: L<Donm::Schema::Result::Indicator>

=cut

__PACKAGE__->belongs_to(
  "indicator",
  "Donm::Schema::Result::Indicator",
  { id => "indicator_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 region

Type: belongs_to

Related object: L<Donm::Schema::Result::Region>

=cut

__PACKAGE__->belongs_to(
  "region",
  "Donm::Schema::Result::Region",
  { id => "region_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-01-05 14:05:41
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:d+0dNkUrDKiEMZuV+uTqiw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
