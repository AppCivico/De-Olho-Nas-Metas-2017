#!/usr/bin/env perl
package Worker;
use common::sense;
use FindBin qw($RealBin);
use lib "$RealBin/../lib";

use Moo;
use MooX::late;
#use EV;
use JSON::XS;
use Net::Curl::Easy qw( :constants );
use Donm::SchemaConnected qw( get_schema );
use Donm::Utils qw( slugify );

extends 'YADA::Worker';

use DDP;

has 'action' => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
);

has schema => (
    is   => 'rw',
    lazy => 1,
    builder => '_build_schema',
);

after init => sub {
    my ($self) = @_;

    $self->setopt(
        CURLOPT_FOLLOWLOCATION => 1,
        CURLOPT_VERBOSE        => $ENV{TRACE} || 0,
        CURLOPT_ENCODING       => '',
        CURLOPT_TCP_KEEPALIVE  => 1,
        CURLOPT_USERAGENT      => 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.78 Safari/537.36',
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

sub data_as_json { decode_json(${$_[0]->data}) } ## no critic

sub _build_schema { get_schema() } ## no critic

sub index {
    my ($self, $res) = @_;

    for my $goal (@{ $res }) {
        my $goal_id = $goal->{meta_numero};
        my $url = "http://planejasampa.prefeitura.sp.gov.br/api/metas/${goal_id}";
        #next unless $goal_id == 2; # TODO Retirar.

        printf "Appending '%s' to queue.\n", $url;
        $self->queue->append(sub {
            Worker->new({
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

    my $topic = $self->schema->resultset('Topic')->search( { 'me.name' =>  $res->{eixo}->[0]->{eixo_nome} } )->next;

    my $unit = _get_unit($res->{meta_unidade_medida});

    my $goal = $self->schema->resultset('Goal')->update_or_create(
        {
            id                         => $goal_id,
            title                      => $res->{meta_nome},
            topic                      => $topic,
            projection_first_biennium  => $res->{meta_projecao_curta},
            projection_second_biennium => $res->{meta_projecao_longa},
            slug                       => slugify($res->{meta_nome}),
            indicator_description      => $res->{meta_descricao},
            unit                       => $unit,
        }
    );

    #p $goal;

    ## TODO Carregar as metas regionalizadas.
    #delete $res->{execucao_regional};

    # Inserindo os projetos na queue.
    #for my $project_id (keys %{ $res->{projetos} || {} }) {
    #    $self->queue->append(sub {
    #        Worker->new({
    #            initial_url => "http://planejasampa.prefeitura.sp.gov.br/api/projetos/${project_id}",
    #            action      => 'project',
    #        });
    #    });
    #}

    #p $res;
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

1;

package main;
use common::sense;
use open ':locale';
use YADA;

use DDP;

my $yada = YADA->new(
    max        => 12,
    allow_dups => 0,
    timeout    => 30,
);

$yada->append(sub {
    Worker->new({
        #initial_url => 'http://planejasampa.prefeitura.sp.gov.br/api/metas',
        initial_url => 'http://127.0.0.1:3000/metas',
        action      => 'index',
        retry       => 3,
    });
});

$yada->wait();

p $yada->stats;

1;
