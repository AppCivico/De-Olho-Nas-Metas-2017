use utf8;
package Donm::Schema::Result::RegionVariable;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::RegionVariable

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

=head1 TABLE: C<region_variable>

=cut

__PACKAGE__->table("region_variable");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'region_variable_id_seq'

=head2 region_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 variable_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 value

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "region_variable_id_seq",
  },
  "region_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "variable_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "value",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<region_variable_region_id_variable_id_key>

=over 4

=item * L</region_id>

=item * L</variable_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "region_variable_region_id_variable_id_key",
  ["region_id", "variable_id"],
);

=head1 RELATIONS

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

=head2 variable

Type: belongs_to

Related object: L<Donm::Schema::Result::Variable>

=cut

__PACKAGE__->belongs_to(
  "variable",
  "Donm::Schema::Result::Variable",
  { id => "variable_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-10-02 12:38:24
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fOXGwBeL1CrNE+4TjAk8zw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
