use utf8;
package Donm::Schema::Result::GoalBadge;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::GoalBadge

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

=head1 TABLE: C<goal_badge>

=cut

__PACKAGE__->table("goal_badge");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'goal_badge_id_seq'

=head2 goal_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 badge_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 updated_at

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "goal_badge_id_seq",
  },
  "goal_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "badge_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
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

=head2 C<goal_badge_goal_id_badge_id_key>

=over 4

=item * L</goal_id>

=item * L</badge_id>

=back

=cut

__PACKAGE__->add_unique_constraint("goal_badge_goal_id_badge_id_key", ["goal_id", "badge_id"]);

=head1 RELATIONS

=head2 badge

Type: belongs_to

Related object: L<Donm::Schema::Result::Badge>

=cut

__PACKAGE__->belongs_to(
  "badge",
  "Donm::Schema::Result::Badge",
  { id => "badge_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 goal

Type: belongs_to

Related object: L<Donm::Schema::Result::Goal>

=cut

__PACKAGE__->belongs_to(
  "goal",
  "Donm::Schema::Result::Goal",
  { id => "goal_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-08-27 15:22:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tYgxPOHHymB/4JsMnZPP7g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
