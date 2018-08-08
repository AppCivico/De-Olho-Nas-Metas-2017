use utf8;
package Donm::Schema::Result::Goal;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Donm::Schema::Result::Goal

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

=head1 TABLE: C<goal>

=cut

__PACKAGE__->table("goal");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=head2 title

  data_type: 'text'
  is_nullable: 0

=head2 topic_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 projection_first_biennium

  data_type: 'text'
  is_nullable: 0

=head2 projection_second_biennium

  data_type: 'text'
  is_nullable: 0

=head2 slug

  data_type: 'text'
  is_nullable: 0

=head2 indicator_description

  data_type: 'text'
  is_nullable: 0

=head2 unit

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 0 },
  "title",
  { data_type => "text", is_nullable => 0 },
  "topic_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "projection_first_biennium",
  { data_type => "text", is_nullable => 0 },
  "projection_second_biennium",
  { data_type => "text", is_nullable => 0 },
  "slug",
  { data_type => "text", is_nullable => 0 },
  "indicator_description",
  { data_type => "text", is_nullable => 0 },
  "unit",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 goal_projects

Type: has_many

Related object: L<Donm::Schema::Result::GoalProject>

=cut

__PACKAGE__->has_many(
  "goal_projects",
  "Donm::Schema::Result::GoalProject",
  { "foreign.goal_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 topic

Type: belongs_to

Related object: L<Donm::Schema::Result::Topic>

=cut

__PACKAGE__->belongs_to(
  "topic",
  "Donm::Schema::Result::Topic",
  { id => "topic_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-08-08 14:58:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zcFhiYKaVBtCR2QpP/V26w

use Number::Format;

sub get_readable_projection_first_biennium {
    my $self = shift;

    my $unit           = $self->get_column('unit');
    my $first_biennium = $self->get_column('projection_first_biennium');

    if (defined($unit)) {
        $first_biennium = $self->_format_value($first_biennium, $unit);
    }

    return $first_biennium;
}

sub get_readable_projection_second_biennium {
    my $self = shift;

    my $unit = $self->get_column('unit');
    my $second_biennium = $self->get_column('projection_second_biennium');

    if (defined($unit)) {
        $second_biennium = $self->_format_value($second_biennium, $unit);
    }

    return $second_biennium;
}

sub _format_value {
    my ($self, $value, $unit) = @_;

    my $nf = new Number::Format(-thousands_sep => '.', -decimal_point => ',', '-int_curr_symbol' => 'R$');

    if ($unit eq 'unit') {
        $value =~ s/,/\./;
        $value = $nf->format_number($value);
    }

    if ($unit eq 'R$') {
        $value = $nf->format_price($value, 2, $unit);
    }

    if ($unit eq '%') {
        $value =~ s/,/\./;
        $value = $value * 100;
        $value =~ s/\./,/;
        $value .= $unit;
    }

    return $value;
}

__PACKAGE__->meta->make_immutable;

1;
