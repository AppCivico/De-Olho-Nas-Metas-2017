-- Deploy donm:0016-goal-indicator to pg
-- requires: 0015-project-description

BEGIN;

ALTER TABLE goal ADD COLUMN indicator_description TEXT ;

UPDATE goal SET indicator_description = 'Indicador de cobertura populacional estimada da atenção básica.' WHERE id = 1;
UPDATE goal SET indicator_description = 'Indicador de mortalidade precoce (30-69 anos) por Doenças Crônicas Não Transmissíveis selecionadas (DCNT).' WHERE id = 2;
UPDATE goal SET indicator_description = 'Sistema de avaliação e certificação da qualidade dos serviços de Saúde, elaborado pela Secretaria Municipal de Saúde.' WHERE id = 3;
UPDATE goal SET indicator_description = 'Tempo médio em dias entre a data de solicitação e a data de realização do exame em relação ao total de agendamentos válidos.' WHERE id = 4;
UPDATE goal SET indicator_description = 'Coeficiente de Mortalidade Infantil.' WHERE id = 5;
UPDATE goal SET indicator_description = 'Número de novas vagas criadas em equipamentos de saúde e assistencia social para atendimento específico do público alvo da ação.' WHERE id = 6;
UPDATE goal SET indicator_description = 'Selos (inicial, intermediário e pleno) adquiridos em conformidade com o Programa São Paulo Amigo do Idoso.' WHERE id = 7;
UPDATE goal SET indicator_description = 'Número de idosos participantes' WHERE id = 8;
UPDATE goal SET indicator_description = 'Percentual de vagas de acolhida em relação à população em situação de rua' WHERE id = 9;
UPDATE goal SET indicator_description = 'Número de furtos e roubos divulgados periodicamente (estatísticas agregadas por ano) pela Secretaria de Segurança Pública do Estado de São Paulo.' WHERE id = 10;
UPDATE goal SET indicator_description = 'O indicador utiliza os resultados da pesquisa VIGITEL: Atividade física no tempo livre, que implica no percentual de adultos que praticam atividades físicas no tempo livre, equivalentes a pelo menos 150 minutos de atividade de intensidade moderada por semana ou atividades de intensidade vigorosa por pelo menos 75 minutos semanais.' WHERE id = 11;
UPDATE goal SET indicator_description = 'Número de matrículas ofertadas em creche (berçário I e II e mini- -grupo I e II) na Rede Municipal de Ensino' WHERE id = 12;
UPDATE goal SET indicator_description = 'IDEB dos anos iniciais do EF, da rede municipal' WHERE id = 13;
UPDATE goal SET indicator_description = 'IDEB dos anos finais do EF, da rede municipal.' WHERE id = 14;
UPDATE goal SET indicator_description = '1) % de alunos nos anos iniciais do EF, da rede municipal, com proficiência, no mínimo, no nível básico na Prova Brasil, em Língua Portuguesa; 2) % de alunos nos anos iniciais do EF, da rede municipal, com proficiência, no mínimo, no nível básico na Prova Brasil, em Matemática; 3) % de alunos nos anos finais do EF, da rede municipal, com proficiência, no mínimo, no nível básico na Prova Brasil, em Língua Portuguesa; 4) % de alunos nos anos finais do EF, da rede municipal, com proficiência, no mínimo, no nível básico na Prova Brasil, em Matemática.' WHERE id = 15;
UPDATE goal SET indicator_description = '% de alunos da rede municipal alfabetizados ao final do segundo ano do EF.' WHERE id = 16;
UPDATE goal SET indicator_description = 'Número de CEUs transformados em polos de inovação em tecnologias educacionais e práticas pedagógicas.' WHERE id = 17;
UPDATE goal SET indicator_description = 'Número de EMEFs com acesso à internet de alta velocidade.' WHERE id = 18;
UPDATE goal SET indicator_description = 'Variação percentual no número total de público frequentador dos equipamentos culturais da Secretaria Municipal de Cultura.' WHERE id = 19;
UPDATE goal SET indicator_description = 'Variação percentual no número de público frequentador do Sistema Municipal de Bibliotecas.' WHERE id = 20;
UPDATE goal SET indicator_description = '1) Número de denúncias encaminhadas' WHERE id = 21;
UPDATE goal SET indicator_description = 'Número de empresas que façam adesão ao modelo de políticas afirmativas na Força de trabalho.' WHERE id = 22;
UPDATE goal SET indicator_description = 'A meta não inclui plantio realizado em procedimentos de compensação ambiental, resultado de subtração (ou arvore cortada). Prefeituras Regionais definidas segundo cobertura vegetal arbórea, mensurada via satélite (cobertura vegetal/área total da regional).' WHERE id = 23;
UPDATE goal SET indicator_description = 'Redução de toneladas de resíduos recebidos pelos aterros municipais, provenientes de resíduos domiciliares, de podas de árvores e feiras livres.' WHERE id = 24;
UPDATE goal SET indicator_description = 'O indicador considera óbitos ocorridos até 30 dias após o acidente de trânsito e a média de ocorrências nos 12 meses anteriores.' WHERE id = 25;
UPDATE goal SET indicator_description = 'Participação, em termos percentuais, da soma dos modos de deslocamento não motorizados (a pé, bicicleta, outros não motorizados, skate) – a chamada mobilidade ativa - em relação ao total dos deslocamentos realizados na cidade de São Paulo. Considerando, ainda, a totalização das etapas percorridas. Para aferição da meta, será considerado o percentual aferido na pesquisa, em relação ao valor de base, acrescido de 2,5% pontos percentuais de oscilação para mais ou menos referentes ao intervalo de confiança da pesquisa.' WHERE id = 26;
UPDATE goal SET indicator_description = 'Somatória das distâncias percorridas pelos passageiros de transporte público coletivo no território de São Paulo, em viagens com origem e destino no município de São Paulo ou origem no município de São Paulo e destino na Região Metropolitana, dividido pela população do município.' WHERE id = 27;
UPDATE goal SET indicator_description = 'Variação percentual da massa de poluentes emitidos ao ano pelo total da frota de ônibus do transporte público municipal até o ano de 2020, em relação ao início de 2017, para cada um dos seus elementos (dióxido de carbono - CO2; material particulado; óxido de nitrogênio - NOx)' WHERE id = 28;
UPDATE goal SET indicator_description = 'Nº de Unidades Habitacionais entregues para atendimento da demanda de habitação de interesse social, via aquisição ou locação social.' WHERE id = 29;
UPDATE goal SET indicator_description = 'Nº de famílias beneficiadas por procedimentos de regularização fundiária em assentamentos precários passíveis de regularização e em consolidação, por meio de aprovação municipal do parcelamento, licenciamento ambiental, registro do parcelamento e entrega de títulos.' WHERE id = 30;
UPDATE goal SET indicator_description = 'Serão consideradas as famílias residentes nos perímetros de intervenção integrada dos assentamentos precários onde serão executadas obras de complexidade alta, média e baixa, excetuando- se aquelas famílias que serão ou que já foram removidas por risco ou para a realização de serviços e obras. O perímetro será determinado pelos setores diretamente beneficiados pela intervenção, quando se tratar de obra pontual.' WHERE id = 31;
UPDATE goal SET indicator_description = 'Percentual de áreas inundáveis controladas.' WHERE id = 32;
UPDATE goal SET indicator_description = 'Percentual de novos projetos de edificações em conformidade com o novo padrão de uso racional da água e eficiência energética.' WHERE id = 33;
UPDATE goal SET indicator_description = 'Quantidade de equipamentos púbicos reformados' WHERE id = 34;
UPDATE goal SET indicator_description = 'Ações de requalificação de espaços públicos com reforma de calçadas e calçadão, melhoria da iluminação pública e implantação de mobiliário urbano.' WHERE id = 35;
UPDATE goal SET indicator_description = 'Elemento médio da série ordenada por tempo de vida de processos de alvará de aprovação, de execução e de aprovação e execução de edificação nova ou reforma e alvarás de licença para residência unifamiliar com despacho de deferimento por Secretaria Municipal de Urbanismo e Licenciamento durante o último ano (365 dias). Mediana é o valor que separa a metade maior e a metade menor de uma amostra.' WHERE id = 36;
UPDATE goal SET indicator_description = 'Agrupamento de municípios em níveis de Insegurança Alimentar (muito alta, alta, média e baixa), de acordo com variáveis de desnutrição infantil (déficit de altura e de peso para idade em crianças menores de 5 anos, acompanhadas pelas condicionalidades do Pograma Bolsa Família) e variáveis socioeconômicas (renda familiar per capta, escolaridade do responsável familiar, acesso à agua e esgotamento sanitário)' WHERE id = 37;
UPDATE goal SET indicator_description = 'Número de beneficiários dos Programas Operação Trabalho, Bolsa Trabalho e Trabalho Novo, somado ao número de trabalhadores colocados no mercado formal de trabalho pelo Sistema Nacional de Emprego (SINE).' WHERE id = 38;
UPDATE goal SET indicator_description = 'Aumento percentual de abertura de empresas relacionadas à cadeia de economia criativa' WHERE id = 39;
UPDATE goal SET indicator_description = 'Ano Base: Doing Business (ver nota técnica) Acompanhamento da meta: Sistema do Empreenda Fácil' WHERE id = 40;
UPDATE goal SET indicator_description = 'Novas regionais com Padrão Poupatempo' WHERE id = 41;
UPDATE goal SET indicator_description = 'Novos pontos WiFi implantados' WHERE id = 42;
UPDATE goal SET indicator_description = 'Percentual de novos processos eletrônicos.' WHERE id = 43;
UPDATE goal SET indicator_description = 'Impacto financeiro compreende recursos relativos a desoneração, receitas de capital e de outorgas, arrecadação tributária e investimentos no período de 2017 a 2020' WHERE id = 44;
UPDATE goal SET indicator_description = 'Investimento Público per capita.' WHERE id = 45;
UPDATE goal SET indicator_description = '% de redução das despesas operacionais da Prefeitura.' WHERE id = 46;
UPDATE goal SET indicator_description = 'Valor do Investimento Estrangeiro Direto Green Field do período entre 2017 e 2020 realizados na Cidade de São Paulo.' WHERE id = 47;
UPDATE goal SET indicator_description = 'Total arrecadado de dívida ativa acumulado a partir de 2017, considerando a inflação' WHERE id = 48;
UPDATE goal SET indicator_description = 'Percentual de bases de dados publicadas em formato aberto com ferramentas básicas de acessibilidade em relação ao total de base de dados contidas no CMBD.' WHERE id = 49;
UPDATE goal SET indicator_description = 'Os nove indicadores são avaliados em um sistema de notas que varia de 0-10. (1) Programa de integridade: Avalia a existência, implementação e acompanhamento; (2) Transparência passiva: média ponderada de (a) Indicador de Qualidade das Respostas ofertadas aos pedidos realizados por meio do SIC – Serviço de Informação ao Cidadão; (b) Indicador de Assiduidade na Rede INFO Aberta; (c) Indicador de eficiência dos encaminhamentos; (3) Transparência ativa: média aritmética simples de: (a) presença da seção Acesso à Informação no site institucional do órgão (b) Presença da seção Participação Social no site institucional do órgão (c) Adequação ao template padrão desenvolvido pela SECOM (d) Apresentação das informações na seção Acesso à Informação (e) Apresentação das informações na seção Participação Social; (4) Número de reclamações atendidas em até 30 dias: nota varia conforme tempo para atendimento; (5) Recomendações de auditorias CGM: concordância ou discordância associada à justificativa e implementação das recomendações; (6) Existência de unidade de controle interno: nota é ponderada conforme a presença ou ausência de Decreto Regulamentador, organograma, servidor com atribuição exclusiva por responder pela coordenadoria e comunicação permanente com CGM a respeito de eventuais fragilidades e encaminhamento periódico dos seus relatórios de atividades; (7) Proporção de contratos emergenciais/contratos totais; (8) Proporção de cargos comissionados puros/ cargos totais; (9) Proporção de pregões eletrônicos/ pregões totais.' WHERE id = 50;
UPDATE goal SET indicator_description = 'Número de seguidores nas mídias sociais da Prefeitura e de visualizações no portal da prefeitura.' WHERE id = 51;
UPDATE goal SET indicator_description = 'Média simples do tempo médio de atendimento dos cinco serviços mais solicitados às prefeituras regionais' WHERE id = 52;
UPDATE goal SET indicator_description = 'Quantidade de ações concentradas de zeladoria urbana realizadas em um determinado ponto/eixo/localização da cidade.' WHERE id = 53;

ALTER TABLE goal ALTER COLUMN indicator_description SET NOT NULL ;

COMMIT;
