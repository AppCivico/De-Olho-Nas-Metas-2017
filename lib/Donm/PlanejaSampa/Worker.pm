#!/usr/bin/env perl
package Donm::PlanejaSampa::Worker;
use common::sense;
use Moo;
use MooX::Types::MooseLike::Base ':all';

use EV;
use JSON::XS;
use Net::Curl::Easy qw(:constants);
use Donm::SchemaConnected qw(get_schema);
use Donm::PlanejaSampa::Loader;

extends 'YADA::Worker';

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
        printf "Error at '%s': %s\n", $self->final_url, $result unless $result =~ m{^No error$};
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

sub index {
    my ($self, $res) = @_;

    for my $goal (@{ $res }) {
        my $goal_id = $goal->{meta_numero};

        $self->queue->append(sub {
            Donm::PlanejaSampa::Worker->new({
                initial_url => "http://planejasampa.prefeitura.sp.gov.br/api/metas/${goal_id}",
                action      => 'goal',
            });
        });
    }
}

sub goal {
    my ($self, $res) = @_;

    my $goal_id = $res->{meta_numero};

    $self->loader->add(
        'goal', {
            id                         => $goal_id,
            title                      => $res->{meta_nome},
            topic                      => $res->{eixo}->[0]->{eixo_nome},
            projection_first_biennium  => $res->{meta_projecao_curta},
            projection_second_biennium => $res->{meta_projecao_longa},
            indicator_description      => $res->{meta_descricao},
            unit                       => $res->{meta_unidade_medida},
            base_value                 => $res->{meta_num_valor_base},
            status                     => $res->{meta_estado},
            secretariat                => $res->{secretaria_descricao},
            last_updated_at            => $res->{meta_ultimo_atualizacao_reg},
        }
    );

    # Selos.
    for my $s ( @{ $res->{selos} || [] } ) {
        $self->loader->add(
            'badge', {
                name => $s->{selo_nome},
            }
        );

        $self->loader->add(
            'goal_badge', {
                goal_id    => $goal_id,
                badge_name => $s->{selo_nome},
            }
        );
    }

    # Execução da meta.
    for my $e (@{ $res->{execucao} }) {
        $self->loader->add(
            'goal_execution', {
                goal_id     => $goal_id,
                period      => $e->{meta_execucao_num_periodo},
                value       => $e->{meta_execucao_valor},
                accumulated => $e->{meta_execucao_valor_acumulado},
            }
        );
    }

    # Execução da meta por região.
    for my $e (@{ $res->{execucao_regional} }) {
        $self->loader->add(
            'goal_execution_subprefecture', {
                goal_id            => $goal_id,
                subprefecture_name => $e->{prefeitura_regional_nome},
                period             => $e->{meta_execucao_prefeitura_regional_num_periodo},
                value              => $e->{meta_execucao_prefeitura_regional_valor},
            }
        );
    }

    # Informações adicionais.
    for my $information (@{ $res->{informacao_adicional} }) {
        $self->loader->add(
            'goal_additional_information', {
                goal_id => $goal_id,
                description => $information->{meta_informacao_adicional_descricao},
                inserted_at => $information->{meta_informacao_adicional_dt_informacao},
            }
        );
    }

    # Inserindo os projetos na queue.
    for my $project_id (keys %{ $res->{projetos} || {} }) {
        $self->queue->append(sub {
             Donm::PlanejaSampa::Worker->new({
                initial_url => "http://planejasampa.prefeitura.sp.gov.br/api/projetos/${project_id}",
                action      => 'project',
            });
        });
    }
}

sub project {
    my ($self, $res) = @_;

    $self->loader->add(
        'project', {
            id               => $res->{dados_cadastrais}->{projeto_numero},
            title            => $res->{dados_cadastrais}->{projeto_nome},
            description      => $res->{dados_cadastrais}->{projeto_descricao},
            expected_results => $res->{dados_cadastrais}->{projeto_resultados_esperados},
            current_scenario => $res->{dados_cadastrais}->{projeto_justificativa},
            budget_own_resources_investment   => $res->{dados_cadastrais}->{orcamento_planejado}->{recursos_proprios}->{investimento},
            budget_own_resources_costing      => $res->{dados_cadastrais}->{orcamento_planejado}->{recursos_proprios}->{custeio},
            budget_other_resources_investment => $res->{dados_cadastrais}->{orcamento_planejado}->{outros_recursos}->{investimento},
            budget_other_resources_costing    => $res->{dados_cadastrais}->{orcamento_planejado}->{outros_recursos}->{custeio},
        }
    );

    for my $badge ( @{ $res->{dados_cadastrais}->{selos} } ) {
        $self->loader->add('badge', { name => $badge->{selo_nome} });

        $self->loader->add(
            'project_badge', {
                project_id => $res->{dados_cadastrais}->{projeto_numero},
                badge_name => $badge->{selo_nome},
            }
        );
    }

    # Carregando a relação no banco.
    for my $goal_id (keys %{ $res->{dados_cadastrais}->{metas} || {} }) {
        $self->queue->append(sub {
            Donm::PlanejaSampa::Worker->new({
                initial_url => "http://planejasampa.prefeitura.sp.gov.br/api/metas/${goal_id}",
                action      => 'goal',
            });
        });

        $self->loader->add(
            'goal_project',
            {
                goal_id    => $goal_id,
                project_id => $res->{dados_cadastrais}->{projeto_numero},
            }
        );
    }

    # Informações adicionais.
    for my $information (@{ $res->{dados_cadastrais}->{projeto_informacao_adicional} }) {
        $self->loader->add(
            'project_additional_information', {
                project_id  => $res->{dados_cadastrais}->{projeto_numero},
                description => $information->{projeto_informacao_adicional_descricao},
                inserted_at => $information->{projeto_informacao_adicional_dt_informacao},
            }
        );
    }

    for (keys %{ $res->{linhas_acao} }) {
        my $action_line = $res->{linhas_acao}->{$_};

        my ($project_id, $id_reference) = split m{\.};

        $self->loader->add(
            'action_line', {
                project_id            => $project_id,
                id_reference          => $id_reference,
                title                 => $action_line->{linha_acao_nome},
                indicator_description => $action_line->{linha_acao_indicadores},
                achievement           => $action_line->{linha_acao_marco},
                indicator             => $action_line->{linha_acao_indicadores},
                status                => $action_line->{linha_acao_estado},
                last_updated_at       => $action_line->{linha_acao_ultimo_atualizacao_exec},
            }
        );

        # Carregando a execução.
        for my $exec (@{ $action_line->{execucao} }) {
            $self->loader->add(
                'action_line_execution' => {
                    action_line_project_id   => $project_id,
                    action_line_id_reference => $id_reference,
                    value                    => $exec->{linha_acao_execucao_valor},
                    period                   => $exec->{linha_acao_execucao_num_periodo},
                    accumulated              => $exec->{linha_acao_execucao_valor_acumulado},
                }
            );
        }
    }

    my $budget_execution = $res->{dados_cadastrais}->{execucao_orcamentaria};
    for my $year (keys %{ $budget_execution }) {
        $self->loader->add(
            'project_budget_execution', {
                project_id => $res->{dados_cadastrais}->{projeto_numero},
                year       => $year,
                own_resources_investment   => $budget_execution->{$year}->{recursos_proprios}->{investimento},
                own_resources_costing      => $budget_execution->{$year}->{recursos_proprios}->{custeio},
                own_resources_total        => $budget_execution->{$year}->{recursos_proprios}->{total},
                other_resources_investment => $budget_execution->{$year}->{outros_recursos}->{investimento},
                other_resources_costing    => $budget_execution->{$year}->{outros_recursos}->{custeio},
                other_resources_total      => $budget_execution->{$year}->{outros_recursos}->{total},
                total_year_investment      => $budget_execution->{$year}->{total_ano}->{investimento},
                total_year_costing         => $budget_execution->{$year}->{total_ano}->{custeio},
                total_year_total           => $budget_execution->{$year}->{total_ano}->{total},
            },
        );
    }

    return;
}

sub _build_loader { return Donm::PlanejaSampa::Loader->instance }

1;
