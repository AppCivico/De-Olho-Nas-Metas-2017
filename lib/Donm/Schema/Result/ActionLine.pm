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

=head2 project_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_reference

  data_type: 'integer'
  is_nullable: 1

=head2 title

  data_type: 'text'
  is_nullable: 1

=head2 indicator_description

  data_type: 'text'
  is_nullable: 1

=head2 achievement

  data_type: 'text'
  is_nullable: 1

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'action_line_id_seq'

=head2 slug

  data_type: 'text'
  is_nullable: 0

=head2 updated_at

  data_type: 'timestamp'
  is_nullable: 1

=head2 indicator

  data_type: 'text'
  is_nullable: 1

=head2 status

  data_type: 'text'
  is_nullable: 1

=head2 last_updated_at

  data_type: 'timestamp'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "project_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_reference",
  { data_type => "integer", is_nullable => 1 },
  "title",
  { data_type => "text", is_nullable => 1 },
  "indicator_description",
  { data_type => "text", is_nullable => 1 },
  "achievement",
  { data_type => "text", is_nullable => 1 },
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "action_line_id_seq",
  },
  "slug",
  { data_type => "text", is_nullable => 0 },
  "updated_at",
  { data_type => "timestamp", is_nullable => 1 },
  "indicator",
  { data_type => "text", is_nullable => 1 },
  "status",
  { data_type => "text", is_nullable => 1 },
  "last_updated_at",
  { data_type => "timestamp", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<action_line_id_reference_project_id_key>

=over 4

=item * L</id_reference>

=item * L</project_id>

=back

=cut

__PACKAGE__->add_unique_constraint(
  "action_line_id_reference_project_id_key",
  ["id_reference", "project_id"],
);

=head2 C<action_line_slug_key>

=over 4

=item * L</slug>

=back

=cut

__PACKAGE__->add_unique_constraint("action_line_slug_key", ["slug"]);

=head1 RELATIONS

=head2 action_line_execution_subprefectures

Type: has_many

Related object: L<Donm::Schema::Result::ActionLineExecutionSubprefecture>

=cut

__PACKAGE__->has_many(
  "action_line_execution_subprefectures",
  "Donm::Schema::Result::ActionLineExecutionSubprefecture",
  {
    "foreign.action_line_id_reference" => "self.id_reference",
    "foreign.action_line_project_id"   => "self.project_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 action_line_executions

Type: has_many

Related object: L<Donm::Schema::Result::ActionLineExecution>

=cut

__PACKAGE__->has_many(
  "action_line_executions",
  "Donm::Schema::Result::ActionLineExecution",
  {
    "foreign.action_line_id_reference" => "self.id_reference",
    "foreign.action_line_project_id"   => "self.project_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 project

Type: belongs_to

Related object: L<Donm::Schema::Result::Project>

=cut

__PACKAGE__->belongs_to(
  "project",
  "Donm::Schema::Result::Project",
  { id => "project_id" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 subprefecture_action_lines

Type: has_many

Related object: L<Donm::Schema::Result::SubprefectureActionLine>

=cut

__PACKAGE__->has_many(
  "subprefecture_action_lines",
  "Donm::Schema::Result::SubprefectureActionLine",
  { "foreign.action_line_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2018-08-28 10:56:42
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3xRnRml7W34FKni0ohdoHw

use Scalar::Util qw(looks_like_number);

sub get_exhibition_id {
    my $self = shift;

    return $self->get_column('project_id') . "." . $self->get_column('id_reference');
}

sub get_projection {
    my $self = shift;

    return $self->action_line_executions->search({ 'me.period' => 9 })->next;
}

sub get_base_value {
    my $self = shift;

    my $base_value = $self->action_line_executions->search({ 'me.period' => 0 })->next;
    if (ref $base_value) {
        my $value = $base_value->get_column('value');
        $value =~ s/^\s+|\s+$//g;
        return $value;
    }
    return undef; ## no critic
}

sub get_base_value_as_number {
    my $self = shift;

    my $base_value = $self->get_base_value() or return undef;

    if (looks_like_number($base_value)) { return $base_value }
    elsif ($base_value eq '')                                 { return undef }
    elsif ($base_value eq '-')                                { return undef }
    elsif ($base_value eq 'NA')                               { return undef }
    elsif ($base_value eq 'N/D')                              { return undef }
    elsif ($base_value eq 'N/A')                              { return undef }
    elsif ($base_value eq 'Nenhum')                           { return undef }
    elsif ($base_value eq 'Nenhuma')                          { return undef }
    elsif ($base_value eq 'Não consta')                       { return undef }
    elsif ($base_value eq 'Não aplicável')                    { return undef }
    elsif ($base_value eq 'Não disponível')                   { return undef }
    elsif ($base_value eq '0,0%')                             { return 0 }
    elsif ($base_value eq '0 vistorias')                      { return 0 }
    elsif ($base_value eq '2 bibliotecas')                    { return 2 }
    elsif ($base_value eq '80 vistorias realizadas')          { return 80 }
    elsif ($base_value eq '230 agentes públicos capacitados') { return 230 }
    elsif ($base_value eq '33 projetos analisados')           { return 33 }
    elsif ($base_value eq '08 selos concedidos')              { return 8 }
    elsif ($base_value eq '0,87%')                            { return 0.87 }
    elsif ($base_value =~ m{^([0-9]+)kbps$})                  { return $1 }
    elsif ($base_value =~ m{^R\$ ([0-9]+(,[0-9]+)?) milhões$}) {
        $base_value = $1;
        $base_value =~ s/,/./g;
        $base_value *= 1000000;
    }
    elsif ($base_value =~ m{^([0-9]+(,[0-9]+)?)$}) {
        $base_value = $1;
        $base_value =~ s/,/./g;
    }
    return undef;
}

sub get_projection_as_number {
    my $self = shift;

    my $base_value = $self->get_base_value() || '';

    my $projection = $self->get_projection();
    return undef unless ref $projection;

    $projection = $projection->get_column('value');
    $projection =~ s/^\s+|\s+$//g;

    my $exhibition_id = $self->get_exhibition_id;

    if (grep { $exhibition_id == $_ } qw/ 4.1 13.1 2.2 1.11 3.9 5.2 6.2 6.5 6.6 7.9 11.11 29.7 58.2 69.5 / ) { return undef } ## no critic
    elsif ($base_value eq 'Não aplicável') { return undef }
    elsif ($base_value eq 'N/A') { return undef }
    elsif ($projection eq '') { return undef }
    elsif ($projection eq 'A definir') { return undef }
    elsif ( $exhibition_id eq '2.1') {
        $projection = $1 if $projection =~ m{^([0-9]+)\%\([0-9]+\)$}g;
    }
    elsif ($projection =~ m{^\-?[0-9]+$}) { return $projection }
    elsif ($projection =~ m{^(\-?[0-9]+(\.[0-9]+)?)$}) { return $projection }
    elsif ($projection =~ m{^([0-9]+,[0-9]+)\%$}) {
        $projection = $1;
        $projection =~ s/,/./g;
    }
    elsif ($projection =~ m{^([0-9]+)\%$}) {
        $projection = $1;
    }
    elsif ($projection eq '512kbps') {
        $projection =~ s/kbps$//g;
    }
    elsif ($projection =~ m{^([0-9]+)\Q% (900)\E$}) {
        $projection = $1;
    }
    elsif ($projection =~ m{^([0-9]+)\Q (+15%)\E$}) {
        $projection = $1;
    }
    elsif ($projection =~ m{^([0-9]+)\Q (30%)\E$}) {
        $projection = $1;
    }
    elsif ($projection =~ m{^[0-9]+\%\s*\(([0-9]+) bibliotecas\)$}) {
        $projection = $1;
    }
    elsif ($projection =~ m{^R\$ ([0-9]+(,[0-9]+)?) milhões$}) {
        $projection = $1;
        $projection =~ s/,/./g;
        $projection *= 1000000;
    }
    elsif ($projection =~ m{^\Q-27% (chegando a R$ \E([0-9]+) milhões\)$}) {
        $projection = $1;
        $projection *= 1000000;
    }

    return undef;
}

__PACKAGE__->meta->make_immutable;

1;
