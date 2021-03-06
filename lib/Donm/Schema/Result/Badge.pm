use utf8;
package Donm::Schema::Result::Badge;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::Badge

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

=head1 TABLE: C<badge>

=cut

__PACKAGE__->table("badge");

=head1 ACCESSORS

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'badge_id_seq'

=head2 updated_at

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "name",
  { data_type => "text", is_nullable => 0 },
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "badge_id_seq",
  },
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

=head2 C<badge_name_key>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("badge_name_key", ["name"]);

=head1 RELATIONS

=head2 goal_badges

Type: has_many

Related object: L<Donm::Schema::Result::GoalBadge>

=cut

__PACKAGE__->has_many(
  "goal_badges",
  "Donm::Schema::Result::GoalBadge",
  { "foreign.badge_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project_badges

Type: has_many

Related object: L<Donm::Schema::Result::ProjectBadge>

=cut

__PACKAGE__->has_many(
  "project_badges",
  "Donm::Schema::Result::ProjectBadge",
  { "foreign.badge_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-08-27 17:29:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:S8lyl+5f9Ouke/Ud2HEekA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
