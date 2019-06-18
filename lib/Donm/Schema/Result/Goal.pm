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

=head2 base_value

  data_type: 'text'
  is_nullable: 1

=head2 updated_at

  data_type: 'timestamp'
  is_nullable: 1

=head2 status

  data_type: 'text'
  is_nullable: 1

=head2 last_updated_at

  data_type: 'timestamp'
  is_nullable: 1

=head2 secretariat_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 temporary_progress

  data_type: 'numeric'
  is_nullable: 1
  size: [5,2]

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
  "base_value",
  { data_type => "text", is_nullable => 1 },
  "updated_at",
  { data_type => "timestamp", is_nullable => 1 },
  "status",
  { data_type => "text", is_nullable => 1 },
  "last_updated_at",
  { data_type => "timestamp", is_nullable => 1 },
  "secretariat_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "temporary_progress",
  { data_type => "numeric", is_nullable => 1, size => [5, 2] },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 goal_additional_informations

Type: has_many

Related object: L<Donm::Schema::Result::GoalAdditionalInformation>

=cut

__PACKAGE__->has_many(
  "goal_additional_informations",
  "Donm::Schema::Result::GoalAdditionalInformation",
  { "foreign.goal_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 goal_badges

Type: has_many

Related object: L<Donm::Schema::Result::GoalBadge>

=cut

__PACKAGE__->has_many(
  "goal_badges",
  "Donm::Schema::Result::GoalBadge",
  { "foreign.goal_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 goal_execution_subprefectures

Type: has_many

Related object: L<Donm::Schema::Result::GoalExecutionSubprefecture>

=cut

__PACKAGE__->has_many(
  "goal_execution_subprefectures",
  "Donm::Schema::Result::GoalExecutionSubprefecture",
  { "foreign.goal_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 goal_executions

Type: has_many

Related object: L<Donm::Schema::Result::GoalExecution>

=cut

__PACKAGE__->has_many(
  "goal_executions",
  "Donm::Schema::Result::GoalExecution",
  { "foreign.goal_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

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

=head2 secretariat

Type: belongs_to

Related object: L<Donm::Schema::Result::Secretariat>

=cut

__PACKAGE__->belongs_to(
  "secretariat",
  "Donm::Schema::Result::Secretariat",
  { id => "secretariat_id" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
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


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-06-18 13:57:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:eJ5lF1oqKi5FfNopdORK3Q

use Number::Format;

sub get_readable_projection_first_biennium {
    my $self = shift;

    my $unit           = $self->get_column('unit');
    my $first_biennium = $self->get_column('projection_first_biennium');

    #if (defined($unit)) {
    #    $first_biennium = $self->_format_value($first_biennium, $unit);
    #}

    return $first_biennium;
}

sub get_readable_projection_second_biennium {
    my $self = shift;

    my $unit = $self->get_column('unit');
    my $second_biennium = $self->get_column('projection_second_biennium');

    #if (defined($unit)) {
    #    $second_biennium = $self->_format_value($second_biennium, $unit);
    #}

    return $second_biennium;
}

sub _format_value {
    my ($self, $value, $unit) = @_;

    my $nf = new Number::Format(-thousands_sep => '.', -decimal_point => ',', '-int_curr_symbol' => 'R$'); ## no critic

    if ($unit eq 'unit') {
        $value =~ s/,/\./;
        $value = $nf->format_number($value);
    }

    if ($unit eq 'R$') {
        $value = $nf->format_price($value, 2, $unit);
    }

    if ($unit eq '%') {
        ($value) = split m{%}, $value if $value =~ m{%};
        $value =~ s/,/\./;
        $value = $value * 100;
        $value =~ s/\./,/;
        $value .= $unit;
    }

    return $value;
}

sub get_projection_as_number {
    my $self = shift;
    my $projection = shift;

    $projection ||= $self->get_column('projection_second_biennium');

    # Normalizando os dados de acordo com a projeção.
    ($projection) = split m{\n}, $projection;
    defined $projection or return undef;
    $projection =~ s/^\s+|\s+$//g;

    my $goal_id = $self->id;

    #if (grep { $goal_id == $_ } qw(9 10 12 40 48 ) ) { return undef }
    if (grep { $goal_id == $_ } qw( 1235315 ) ) { return undef }
    elsif ($projection eq 'A definir')               { return undef }
    elsif ($projection eq 'N/A')                     { return undef }
    elsif ($projection eq '15.000' && $goal_id == 8) { return 15000 }
    elsif ($projection =~ m{^[0-9]+(\.[0-9]+)?$})    { return $projection }
    elsif ($projection =~ m{^[0-9]+(,[0-9]+)?%$}) {
        $projection =~ s/,/./g;
        $projection =~ s/%//g;
    }
    elsif ($projection =~ m{^([0-9]+)\s+mil$}) {
        $projection = $1;
        $projection *= 1000;
    }
    elsif ($projection =~ m{^\Q-112.000 toneladas\E$}) { return undef }
    elsif ($projection =~ m{^([0-9]+(,[0-9]+)?)\Q mortes/ 100.000 habitantes\E$}) {
        $projection = $1;
        $projection =~ s/,/./g;
    }
    elsif ($projection =~ m{\QCOM RECURSOS DE OUTROS ENTES: \E([0-9]+(\.[0-9]+)?);}) {
        $projection = $1;
        $projection =~ s/\.//g;
    }
    elsif ($projection =~ m{^([0-9]+) dias$}) {
        $projection = $1;
    }
    elsif ($projection =~ m{^[0-9,]+%\Q (R$ \E([0-9\.,]+) per capita\)$}) { return undef }
    elsif ($projection =~ m{^-[0-9]+% \(R\$ ([0-9]+)\Q milhões mais correção monetária)\E}) {
        $projection = $1;
    }
    elsif ($projection =~ m{^([0-9]+(,[0-9]+)?)$}) {
        $projection =~ s/,/./;
    }
    elsif ($projection =~ m{^([0-9]+) (ações|pontos)$}) {
        $projection = $1;
    }
    elsif ($projection =~ m{^([0-9]+(,[0-9]+)?) em 1(00)?\.000$}) {
        $projection = $1;
        $projection =~ s/,/./;
    }
    elsif ($projection =~ m{^([0-9\.]+,[0-9]+)$}) {
        $projection =~ s/\.//g;
        $projection =~ s/,/./g;
    }
    elsif ($projection =~ m{^[0-9]+% \(([0-9\.]+)\);$}) {
        $projection = $1;
        $projection =~ s/\.//g;
    }
    elsif ($projection =~ m{^([0-9]+(,[0-9]+)?) km² \(}) {
        $projection = $1;
        $projection =~ s/,/./g;
    }
    elsif ($projection =~ m{^(\d+) regionais$}) {
        $projection = $1;
    }
    elsif ($projection =~ m{^R\$ ([0-9\.]+)\*?$}) {
        $projection = $1;
        $projection =~ s/\.//g;
    }
    elsif ($projection =~ m{^([0-9]+)\s+mil m²$}) {
        $projection = $1;
        $projection *= 1000;
    }
    elsif ($projection =~ m{^[0-9]+\Q% (VIGITEL: \E([0-9]+(,?[0-9]+)?)\%\)$}) {
        $projection = $1;
        $projection =~ s/,/./g;
    }
    else {
        print STDERR "Unknown projection '$projection' of goal id '$goal_id'.\n";
        return undef;
    }

    return $projection;
}

sub is_all_goal_executions_accumulated {
    my ($self) = @_;

    my @goal_executions = $self->goal_executions
      ->search(undef, { result_class => 'DBIx::Class::ResultClass::HashRefInflator' } )
      ->all();

    for my $e (grep { $_->{accumulated} } @goal_executions) {
        my $period  = $e->{period};
        my $goal_id = $e->{goal_id};

        my ($not_accumulated_in_this_period) = grep {
            $_->{accumulated} == 0
            && $_->{period}   == $period
            && $_->{goal_id}  == $goal_id
        } @goal_executions;

        if (ref $not_accumulated_in_this_period && q...$not_accumulated_in_this_period->{value} ne q...$e->{value}) {
            return 0;
        }
    }
    return 1;
}

sub get_temporary_progress {
    my $self = shift;

    my $temporary_progress = $self->temporary_progress;

    return $temporary_progress;
    #if (defined($temporary_progress)) {
    #    return sprintf('%.2f', $temporary_progress);
    #}
    #return;
}

sub get_total_progress {
    my $self = shift;

    # Projeção.
    my $projection = $self->get_projection_as_number() or return;

    # Valor base.
    my $base_value = $self->get_column('base_value') or return;
    if ($base_value =~ m{^N/?A$}) {
        return;
    }

    # Obtendo a última execução.
    my $last_accumulated_goal_execution = $self->goal_executions->search(
        { 'me.accumulated' => 'true' },
        {
            order_by => [ { '-desc' => 'me.period' } ],
            rows     => 1,
        }
    )->next();

    if (ref $last_accumulated_goal_execution) {
        my $value = $last_accumulated_goal_execution->get_value_as_number() or return;

        # Progresso.
        my $projection_base_diff = $projection - $base_value;
        $projection_base_diff ||= 1; # Avoid illegal division by zero.

        my $progress = sprintf('%.2f', ( ( ($value - $base_value) * 100 ) / $projection_base_diff ));
        return 0 if $progress == 0;
        return $progress;
    }

    return;
}

__PACKAGE__->meta->make_immutable;

1;
