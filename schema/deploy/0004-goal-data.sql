-- Deploy donm:0004-goal-data to pg
-- requires: 0003-project-data

BEGIN;

COPY goal (id, title) FROM stdin;
1	Aumentar a cobertura da Atenção Básica à Saúde para 70% na cidade de São Paulo.
2	Reduzir em 5% (7 óbitos prematuros em 100.000 residentes) a taxa de mortalidade precoce por Doenças Crônicas Não Transmissíveis selecionadas, contribuindo para o aumento da expectativa de vida saudável.
7	Transformar São Paulo em Cidade Amiga do Idoso, obtendo o selo pleno do Programa São Paulo Amigo do Idoso.
25	Reduzir o índice de mortes no trânsito para valor igual ou inferior a 6 a cada 100 mil habitantes ao ano até 2020.
3	Certificar 75% (630) dos estabelecimentos municipais de saúde conforme critérios de qualidade, humanização e segurança do paciente.
4	Reduzir o tempo médio de espera para exames prioritários para 30 dias na cidade de São Paulo.
5	Diminuir a taxa de mortalidade infantil em 5% (0,6 óbitos em 1.000 residentes) na cidade de São Paulo, priorizando regiões com as maiores taxas.
6	Criar 2.000 novas vagas para atendimento humanizado em saúde e assistência social especificamente para pessoas em situação de uso abusivo de álcool e outras drogas.
9	Assegurar acolhimento para, no mínimo, 90% da população em situação de rua.
38	Gerar oportunidades de inclusão produtiva, por meio das ações de qualificação profissional, intermediação de mão de obra e empreendedorismo, para 70 mil pessoas que vivem em situação de pobreza, especialmente para a população em situação de rua.
21	Garantir 100% de encaminhamentos das denúncias recebidas contra populações vulneráveis.
8	Garantir 15.000 vagas de atividades para idosos com objetivo de convívio e participação na comunidade.
10	Contribuir para a redução dos crimes de oportunidade em 10% (42.901) na cidade de São Paulo.
11	Ampliar em 20% a taxa de atividade física na cidade de São Paulo.
12	Expandir em 30% (85,5 mil) as matrículas em creche na Rede Municipal de Ensino.
13	Atingir IDEB de 6,5 nos anos iniciais do Ensino Fundamental.
14	Atingir IDEB de 5,8 nos anos finais do Ensino Fundamental.
15	95% dos alunos com, no mínimo, nível de proficiência básico na Prova Brasil, nos anos iniciais e finais do Ensino Fundamental.
16	Alcançar 95% dos alunos alfabetizados ao final do segundo ano do Ensino Fundamental (EF).
17	100% (46) dos CEUs transformados em polos de inovação em tecnologias educacionais e práticas pedagógicas.
18	Todo aluno e todo professor em escolas municipais de Ensino Fundamental com acesso à internet de alta velocidade.
19	Aumentar em 15% (504.535) o público total frequentador dos equipamentos culturais.
20	Aumentar em 15% (142.820) o público frequentador do Sistema Municipal de Bibliotecas.
22	Alcançar 150 empresas que façam a adesão voluntária ao selo municipal de princípios de direitos humanos e diversidade na cidade de São Paulo.
23	Plantar 200 mil árvores no município, com prioridade para as 10 Prefeituras Regionais com menor cobertura vegetal.
24	Reduzir em 500 mil toneladas o total dos resíduos enviados a aterros municipais no período de 4 anos, em comparação ao total do período 2013-2016.
27	Aumentar em 7% o uso do transporte público em São Paulo até 2020.
26	Aumentar em 10% a participação dos modos ativos de deslocamento (de bicicleta, a pé e outros modos ativos), até 2020.
28	Reduzir em 15% (156.649 ton) a emissão de CO2, em 50% (37 ton) a emissão de material particulado e em 40% (1.999 ton) a emissão de NOx pela frota de ônibus municipais até 2020.
29	25 mil Unidades Habitacionais entregues para atendimento via aquisição ou via locação social.
30	210 mil famílias beneficiadas por procedimentos de regularização fundiária. 
31	27.500 famílias beneficiadas com Urbanização Integrada em Assentamentos Precários.
32	Reduzir em 15% (3,4 km²) as áreas inundáveis da cidade.
33	Implantar um novo padrão de uso racional da água e eficiência energética em 100% dos novos projetos de edificações.
34	Melhorar as condições de acessibilidade em 200 equipamentos públicos existentes.
35	Valorização do Centro com intervenções urbanísticas visando a requalificação e revitalização de espaços livres e passeios públicos em 145 mil m².
36	Reduzir o tempo médio de emissão dos alvarás de aprovação e execução de construções de 532 dias para 210 dias.
37	Melhorar a classificação de São Paulo no Mapa de Insegurança Alimentar de Média para Baixa.
39	Aumentar em 10% (1.353), entre 2017 e 2019, a quantidade de empresas abertas relacionadas à cadeia de economia criativa em comparação ao triênio 2013-2015.
40	Reduzir o tempo para abertura e formalização de empresas de baixo risco para 5 dias.
41	Implantar o Padrão Poupatempo em todas as 32 regionais.
42	Duplicar os pontos de WiFi Livre (criando mais 120 pontos) na cidade de São Paulo.
43	Garantir que 100% dos novos processos sejam eletrônicos, reduzindo custos e tempos de tramitação.
44	Viabilizar R$ 5 bilhões de impacto financeiro para a Prefeitura de São Paulo por meio de projetos de desestatização e de parcerias com o setor privado.
47	Aumentar em 10% (R$ 1,17 bilhão) o valor acumulado de Investimento Estrangeiro Direto em relação aos últimos quatro anos.
45	Aumentar em 20% (R$ 224,58), no período de 2017 a 2020, o investimento público per capita em relação ao período de 2013 a 2016.
46	Reduzir 20% das despesas operacionais (R$ 96,6 milhões) em relação ao triênio anterior (2014/2016).
48	Ampliar em 10% (R$ 989 milhões) a arrecadação da dívida ativa do município, em relação aos últimos quatro anos.
49	Garantir que 100% dos dados publicados pela Prefeitura estejam disponíveis em formato aberto, integrando ferramentas básicas de acessibilidade.
50	Aumentar em 50% (2,65) o Índice de Integridade da Prefeitura de São Paulo.
51	Duplicar as visualizações (34,5 milhões) do portal da Prefeitura Municipal de São Paulo e o número de seguidores nas mídias sociais (300 mil) institucionais.
52	Reduzir de 90 para 70 dias o tempo médio de atendimento dos cinco principais serviços solicitados às Prefeituras Regionais, em relação aos últimos quatro anos.
53	Garantir ações concentradas de zeladoria urbana em 200 eixos e marcos estratégicos da cidade de São Paulo.
\.

COMMIT;
