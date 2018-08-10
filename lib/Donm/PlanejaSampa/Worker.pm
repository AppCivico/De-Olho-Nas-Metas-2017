#!/usr/bin/env perl
package Donm::PlanejaSampa::Worker;
use common::sense;
use Moo;
use MooX::Types::MooseLike::Base ':all';

use EV;
use JSON::XS;
use Net::Curl::Easy qw(:constants);
use Donm::SchemaConnected qw(get_schema);
use Donm::Utils qw(slugify);
use Donm::PlanejaSampa::Loader;

extends 'YADA::Worker';

use DDP;

has action => (
    is       => 'rw',
    isa      => Str,
);

has loader => (
    is  => 'rw',
    isa => AllOf[
        InstanceOf['Donm::PlanejaSampa::Loader'],
        ConsumerOf['MooX::Singleton'],
    ],
    lazy    => 1,
    builder => '_build_loader',
);

after init => sub {
    my ($self) = @_;

    $self->setopt(
        followlocation => 1,
        verbose        => $ENV{TRACE} || 0,
        encoding       => '',
        useragent      => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.78 Safari/537.36',
    );
};

after finish => sub {
    my ($self, $result) = @_;

    if ($self->has_error) {
        printf "Error at '%s': %s\n", $self->final_url, $result;
        return 0;
    }

    printf "Download '%s' (%d bytes)\n", $self->final_url, length ${$self->data};

    my $action = $self->action;
    $self->$action($self->data_as_json) if $action;
};

around has_error => sub {
    my $orig = shift;
    my $self = shift;

    return 1 if $self->$orig(@_);
    return 1 if $self->getinfo(Net::Curl::Easy::CURLINFO_RESPONSE_CODE) !~ m{^20[0-2]$};

    eval { $self->data_as_json };
    return 1 if $@;

    return 0;
};

sub data_as_json { return decode_json(${$_[0]->data}) } ## no critic

sub index {
    my ($self, $res) = @_;

    for my $goal (@{ $res }) {
        my $goal_id = $goal->{meta_numero};
        my $url = "http://planejasampa.prefeitura.sp.gov.br/api/metas/${goal_id}";

        #next unless $goal_id == 2; # TODO Retirar.

        printf "Appending '%s' to queue.\n", $url;
        $self->queue->append(sub {
            Donm::PlanejaSampa::Worker->new({
                initial_url => $url,
                action      => 'goal',
            });
        });
    }
}

sub goal {
    my ($self, $res) = @_;

    my $goal_id    = $res->{meta_numero};
    my $base_value = $res->{meta_num_valor_base};

    my $unit = _get_unit($res->{meta_unidade_medida});

    $self->loader->add(
        'goal',
        {
            id                         => $goal_id,
            title                      => $res->{meta_nome},
            topic                      => $res->{eixo}->[0]->{eixo_nome},
            projection_first_biennium  => $res->{meta_projecao_curta},
            projection_second_biennium => $res->{meta_projecao_longa},
            slug                       => slugify($res->{meta_nome}),
            indicator_description      => $res->{meta_descricao},
            unit                       => $unit,
            base_value                 => $res->{meta_num_valor_base},
        }
    );

    # TODO Carregar o progresso
    # TODO Carregar as metas regionalizadas.
    delete $res->{execucao_regional};

    # Inserindo os projetos na queue.
    for my $project_id (keys %{ $res->{projetos} || {} }) {
       #$self->queue->append(sub {
       #    Donm::PlanejaSampa::Worker->new({
       #        initial_url => "http://planejasampa.prefeitura.sp.gov.br/api/projetos/${project_id}",
       #        action      => 'project',
       #    });
       #});
    }
}

sub _get_unit {
    my ($unit) = @_;

    if ($unit eq 'Unidade') {
        return 'unit';
    }
    elsif ($unit =~ m{^R\$}) {
        return 'R$';
    }
    elsif ($unit eq '%') {
        return $unit;
    }
    return;
}

sub project {
    my ($self, $res) = @_;

    for (keys %{ $res->{linhas_acao} }) {
        my $action_line = $res->{linhas_acao}->{$_};

        my ($project_id, $id_reference) = split m{\.};

        #p $project_id;
        #p $id_reference;
    }
}

sub _build_loader { return Donm::PlanejaSampa::Loader->instance }

1;