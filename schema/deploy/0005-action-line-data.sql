-- Deploy donm:0005-action-line-data to pg
-- requires: 0004-goal-data

BEGIN;

COPY action_line (id, subid, title) FROM stdin;
1	1	Implantar 100 novas equipes de Estratégia de Saúde da Família (ESF) no município, considerando a expansão proporcional de toda a rede de apoio, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
1	2	Implantar novas equipes de Atenção Básica com 700 profissionais médicos, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
1	3	Implantar 33 novos Núcleos de Apoio à Estratégia da Família - N/ASF, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
1	4	Implantar 100 novas equipes de Saúde Bucal, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
1	5	Limitar a no máximo 5% a perda primária de consultas médicas (vagas disponibilizadas, mas não utilizadas) nas Unidades Básicas de Saúde (UBS).
1	6	Promover a educação permanente de 25% dos profissionais da saúde por Prefeitura Regional para adesão a protocolos da Atenção Básica, com destaque para ações de enfrentamento da violência e populações vulneráveis.
1	7	Garantir o abastecimento de todas as unidades com os insumos e os medicamentos necessários para o seu funcionamento, reduzindo o índice de desabastecimento médio para níveis aceitáveis (até 15%).
1	8	Ampliar o número de ações intersetoriais de prevenção e promoção à saúde, realizadas nas 32 prefeituras regionais (no mínimo 4 em 2020).
1	9	Entregar 14 novas Unidades Básicas de Saúde (UBS), na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
1	10	Readequar, reformar e/ou reequipar 1/3 das Unidades Básicas de Saúde (150 UBS), garantindo melhorias na acessibilidade e segurança do paciente, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
1	11	Aumentar a cobertura de exames de Papanicolau na faixa etária alvo (25-64 anos) em 10%.
2	1	Fortalecer as ações de rastreamento e implantar o monitoramento da abordagem mínima e básica do Programa de combate ao Tabagismo nas unidades de saúde, garantindo-as em 100% das Unidades Básicas de Saúde (452 UBS).
2	2	Aumentar para 95% o número de Unidades Básicas de Saúde (430 UBS) que oferecem Práticas Integrativas e Complementares (PIC) em Saúde para o combate da inatividade física, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
2	3	Ampliar o desenvolvimento de ações individuais e coletivas de promoção da alimentação saudável para a garantia da segurança alimentar e nutricional da população.
2	4	Elaborar e implantar nas 6 Coordenadorias Regionais de Saúde o plano de ação para o rastreamento dos fatores de risco para DCNT (dislipidemia, hipertensão arterial, diabetes tipo II, uso de álcool, obesidade).
2	5	Elaborar e implantar, junto às 6 Coordenadorias Regionais de Saúde, os Planos Regionais de Atenção Integral à Saúde do Homem.
2	6	Fortalecer a capacidade de resposta da Atenção Básica no enfrentamento das DCNT por meio de ações de educação permanente junto às Coordenadorias de Saúde, com objetivo de elaborar os “Planos Regionais de educação permanente para o Enfrentamento das DCNT”.
2	7	Diminuir a mortalidade por insuficiência cardíaca descompensada nas unidades de emergência em 40%.
2	8	Diminuir a mortalidade por Acidente Vascular Encefálico (AVE) para 10% nas unidades de emergência.
2	9	Diminuir a mortalidade por Infarto Agudo do Miocárdio (IAM) para 8% nas unidades de emergência.
2	10	Implantar 5 Centros Especializados de Reabilitação (CER) na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
2	11	Revitalizar 25 Serviços de Reabilitação já existentes, garantindo melhorias na acessibilidade e segurança do paciente, de forma a habilitá-los e/ou mantê-los como Centros Especializados de Reabilitação (CER).
2	12	Ampliar em 15% (5.059) o fornecimento de órteses, próteses e meios auxiliares de locomoção (OPM) nos serviços de reabilitação, garantindo o cumprimento de critérios técnicos e éticos para contratação de empresas fornecedoras.
3	1	Implantar o Programa “SAMU 192 - Cuidado Básico”, ampliando para 75% o percentual de atendimento de demandas de baixa prioridade, conforme protocolo vigente, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
3	2	Implantar o Programa “SAMU 192 - Cuidado Prioritário”,garantindo o atendimento de pelo menos 50% das demandas de alta prioridade (Acidente Vascular Cerebral, Infarto Agudo do Miocárdio e Trauma) em até 12 minutos, conforme protocolo vigente, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
3	3	Implantar o Programa “SAMU 192 - Saúde Mental”, ampliando o número de atendimentos para 70% , na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
3	4	Implantar o Programa “SAMU 192 - Vias Seguras”, introduzindo 6 Veículos de Intervenção Rápida (VIR) em locais de maior ocorrência de acidentes, reduzindo o tempo médio de resposta de atendimento, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
3	5	Organizar as equipes do SAMU em 125 bases descentralizadas integradas às unidades identificadas, conforme nível de complexidade, atendendo as diretrizes da Portaria nº 2657 GM/MS, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
3	6	Garantir a operacionalização ininterrupta (24 horas por dia) de 122 viaturas de Suporte Básico de Vida habilitadas, 26 viaturas de Suporte Avançado, bem como de 6 Veículos de Intervenção Rápida.
3	7	Implantar interface com a Companhia de Engenharia de Tráfego (CET) que permita comunicação bidirecional de ocorrências no trânsito.
3	8	Capacitar as unidades de urgência e emergência (158) de gestão municipal em conformidade com as linhas de cuidado prioritárias da Rede de Urgência e Emergência - RUE (Acidente Vascular Cerebral, Infarto Agudo do Miocárdio e Trauma).
3	9	Padronizar e implantar a classificação de risco em todas as unidades de acolhimento de urgência (158) de gestão municipal, de forma ininterrupta.
3	10	Garantir a cobertura de plantões por profissionais de saúde nas unidades de acolhimento de urgências e emergências (158) de gestão municipal.
3	11	Implantar 12 serviços de urgência e emergência, ampliando a rede de unidades disponíveis.
3	12	Reformar e/ou Readequar as 33 unidades da Rede de Urgência e Emergência levando em consideração critérios de acessibilidade e segurança do paciente, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
3	13	Entregar 2 novos hospitais, na perspectiva de constituição das Redes de Atenção à Saúde.
30	6	Realizar mapeamento do acervo para permitir sua renovação.
4	1	Implantar o prontuário eletrônico em 70% dos hospitais da Rede Municipal de Saúde (13), na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
4	2	Implantar o prontuário eletrônico em 50% dos Ambulatórios de Especialidades da Rede Municipal de Saúde (30), na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
4	3	Implantar o prontuário eletrônico em 100% (452) das Unidades Básicas de Saúde (UBS), na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
4	4	Desenvolver Aplicativo para que os Usuários do Sistema Único de Saúde (SUS) possam conhecer informações sobre os serviços mais adequados, próximos e qualificados para os atendimentos de saúde pretendidos ou necessários.
4	5	Prover aos usuários do SUS do município o acesso digital direto ao sistema de agendamento de suas consultas, exames e procedimentos.
4	6	Ampliar o Telessaúde, garantindo a cobertura de todas as 452 Unidades Básicas de Saúde (UBS).
5	1	Estabelecer e publicar os requisitos do Modelo Municipal de Gestão da Qualidade, Humanização e Segurança do Paciente para os estabelecimentos da Rede Municipal de Saúde da cidade de São Paulo, considerando requisitos de acessibilidade.
5	2	Ter pelo menos um multiplicador capacitado no Modelo Municipal de Gestão da Qualidade, Humanização e Segurança do Paciente da SMS em todos os estabelecimentos da Rede Municipal de Saúde da cidade de São Paulo (841), na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
5	3	Realizar diagnóstico de todos os estabelecimentos da Rede Municipal de Saúde da cidade de São Paulo (841), na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
5	4	Definir planos de ação para que no mínimo 75% dos estabelecimentos da Rede Municipal de Saúde da cidade de São Paulo (630) alcancem pelo menos o nível básico do Modelo de Gestão da Qualidade, Humanização e Segurança do Paciente da SMS-SP, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
5	5	Avaliar através de auditoria e certificar os estabelecimentos da Rede Municipal de Saúde da cidade de São Paulo.
5	6	Implantar Prêmio Anual Municipal de Gestão da Qualidade, Humanização e Segurança do Paciente e realizá-lo anualmente.
6	1	Desenvolver e aplicar protocolos de acesso a exames prioritários, incluindo indicações clínicas e profissionais solicitantes, definidos com base no nível de atenção e na hipótese diagnóstica, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
6	2	Realizar educação permanente na modalidade de Educação a distância - EAD para os profissionais solicitantes e reguladores de 100% das Unidades Básicas de Saúde (UBS) e dos Ambulatórios de Especialidades (AE) para aplicação dos protocolos de encaminhamentos e solicitação de exames prioritários, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
6	3	Garantir a equipe necessária para atuar com serviços de regulação nas Unidades Básicas de Saúde (UBS) e nos Ambulatórios de Especialidades (AE), na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
6	4	Reduzir o absenteísmo - não comparecimento dos pacientes aos exames - para 20%.
6	5	Manter a perda primária - não ocupação de vagas para exames disponibilizadas - abaixo de 5%.
6	6	Ampliar a disponibilidade de vagas de exames prioritários em 10%.
7	1	Aumentar em 100% a disponibilidade anual de métodos contraceptivos de longa permanência (implante subdérmico), principalmente às mulheres e adolescentes em situação de vulnerabilidade, que assim desejarem, seguindo protocolo do planejamento reprodutivo adequado (Organização Mundial de Saúde), que prevê o consentimento livre e esclarecido das interessadas.
7	2	Fortalecer o pré-natal, primeira consulta da gestante até 12ª semana de gestação, realizando a busca ativa com ênfase nos grupos vulneráveis.
7	3	Qualificar a atenção ao recém-nascido nas maternidades municipais por meio: 1) do manejo obstétrico na imaturidade pulmonar e nas complicações do parto. 2) da prevenção de infecções. 3) da atualização das equipes de neonatologia em reanimação neonatal e nos protocolos clínicos.
7	4	Aumentar em 100% a disponibilidade anual de métodos contraceptivos de longa permanência (Dispostivo Intrauterino), principalmente às mulheres e adolescentes em situação de vulnerabilidade, que assim desejarem, seguindo protocolo do planejamento reprodutivo adequado (Organização Mundial de Saúde), que prevê o consentimento livre e esclarecido das interessadas.
7	5	Garantir a realização da 1ª consulta do recém-nascido em até 07 dias na Atenção Básica ou na visita domiciliar para avaliar o bebê e orientar rotinas.
7	6	Implantar grupos de alta qualificada nas 8 maternidades municipais (com orientações à puérpera e seu acompanhante quanto à importância do aleitamento materno, cuidados de higiene, prevenção de riscos, acompanhamento da mãe e do bebê na Atenção Básica, etc.).
7	7	Capacitar 75% das equipes de Estratégia de Saúde da Família (ESF) para o aleitamento materno exclusivo até 6º mês de vida e alimentação complementar saudável até pelo menos 2º ano.
7	8	Implementar e monitorar ações de incentivo ao aleitamento materno e introdução de alimentação complementar adequada em 100% das UBS cujas equipes de Estratégia de Saúde da Família tenham sido capacitadas.
7	9	Manter as taxas de parto normal nas maternidades sob gestão municipal acima de 65%.
7	10	Capacitar 100% das Equipes de Estratégia de Saúde da Família (médicos e enfermeiros) para as Doenças prevalentes no período neonatal e no 1º ano de vida.
7	11	Favorecer as boas práticas para o parto normal e os cuidados de saúde às gestantes.
8	1	Formular e publicar a Política Municipal de Álcool e outras Drogas.
8	2	Implantar uma central para monitoramento e promoção da transparência das ações relacionadas à população.
8	3	Formular e publicar protocolo de atendimento intersecretarial entre SMS e SMADS voltado a pessoas em situação de uso abusivo de álcool e outras drogas.
8	4	Publicar protocolo de atendimento socioassistêncial para pessoas em situação de uso abusivo de alcool e outras drogas, contemplando o encaminhamento à rede de acolhimento.
8	5	Publicar protocolo de encaminhamento de pessoas em situação de uso abusivo de álcool e drogas entre os equipamentos das Redes de Atenção à Saúde, seguindo a Política Municipal de Álcool e outras Drogas.
8	6	Capacitar equipes do Serviço Especializado de Abordagem Social às Pessoas em Situação de Rua que Fazem Uso das Ruas para o Consumo Abusivo de Substâncias Psicoativas em Cenas de Uso - SEAS IV.
8	7	Capacitar todas as equipes de abordagem do Programa Consultório na Rua para o atendimento ao público em situação de uso abusivo de álcool e outras drogas.
8	8	Implantar 10 novas equipes do Programa Consultório na Rua.
8	9	Criar 75 novas vagas em Centros de Atenção Psicosocial - CAPS AD, por meio da reclassificação de 15 CAPS AD II para III, permitindo o acolhimento das pessoas em situação de crise por uso abusivo de álcool e drogas durante o período noturno.
8	10	Criar 970 vagas para acolhimento social em repúblicas; centros de acolhida; centros temporários de acolhimento; e aluguel social voltadas às pessoas em situação de vulnerabilidade social em função do uso abusivo de drogas.
8	11	Criar 100 vagas em Serviços de Residências Terapêuticas - SRT, voltadas às pessoas com transtornos mentais e em situação de uso abusivo de álcool e outras drogas.
8	12	Criar 250 novas vagas em Unidades de Acolhimento - UA, para acompanhamento terapêutico de pessoas com necessidades decorrentes do uso abusivo de álcool e outras drogas.
8	13	Criar 500 vagas relativas a leitos hospitalares de desintoxicação de álcool e outras drogas.
8	14	Implantar um cadastro unificado e integrado na rede de atendimento em álcool e outras drogas.
8	15	Criar 105 novas vagas em Centros de Atenção Psicosocial - CAPS III, por meio da implantação de 21 novos CAPS III, permitindo o acolhimento das pessoas em situação de crise por uso abusivo de álcool e drogas durante o período noturno.
8	16	Instalar Unidade Avançada de Extensão do Centro de Atenção Psicossocial - CAPS, conforme necessidades de atendimento de pessoas em situação de uso abusivo de álcool e outras drogas.
8	17	Produzir e difundir material educativo de saúde sobre os efeitos nocivos do uso abusivo de álcool e outras drogas.
8	18	Realizar campanhas de prevenção e conscientização sobre os efeitos nocivos de uso abusivo de álcool e outras drogas.
9	1	Articular 35.000 vagas em empresas para recepção de trabalhadores oriundos da situação de rua.
9	2	Capacitar 35.000 cidadãos em situação de rua em diferentes áreas - formação humana, comportamental, financeira e técnica para a inserção no mundo do trabalho.
9	3	Capacitar equipes das empresas receptoras dos trabalhadores oriundos da situação de rua para adequada recepção a este público.
9	4	Acompanhar junto aos setores de Recursos Humanos das empresas a situação dos cidadãos encaminhados.
9	5	Estabelecer parceria para a inserção de pessoas em situação de rua em negócios sociais vinculados à agricultura orgânica urbana.
9	6	Firmar parceria com Poupatempo para emissão facilitada de documentos.
9	7	Firmar parceria com Receita Federal para emissão facilitada de documentos.
9	8	Firmar parceria com Exército Brasileiro para emissão facilitada de documentos.
9	9	Firmar parceria com Defensoria Pública para emissão facilitada de documentos.
9	10	Estabelecer protocolo socioassistêncial e de fluxo de reinserção social voltado especificamente para o público em situação de uso abusivo de álcool e outras drogas.
10	1	Desenvolver protocolos de atendimento e encaminhamento.
10	2	Constituir equipes para atendimento rotativo.
10	3	Realizar a formação das equipes de atendimento dos balcões de cidadania.
10	4	Implementar balcões de cidadania nas zonas da cidade por meio de parcerias com outros órgãos de atendimento ao munícipe.
10	5	Implementar sistema de agendamento para uso do balcão de cidadania que permita atendimento na sua zona por uma equipe especializada.
10	6	Desenvolver e aplicar questionário de avaliação do cidadão sobre o serviço de atendimento.
10	7	Garantir satisfação média com o serviço de atendimento de pelo menos 70%.
10	8	Implementar aplicativo para denúncias de violações de Direitos Humanos.
11	1	Obter o Selo Amigo do Idoso INICIAL (Secretaria de Desenvolvimento Social do Estado de São Paulo).
11	2	Obter o Selo Amigo do Idoso INTERMEDIÁRIO (Secretaria de Desenvolvimento Social do Estado de São Paulo).
11	3	Obter o Selo Amigo do Idoso PLENO (Secretaria de Desenvolvimento Social do Estado de São Paulo).
11	4	Implantar a Rede de Atenção à Saúde da Pessoa Idosa – RASPI em toda a cidade de São Paulo.
11	5	Realizar a Avaliação Multidimensional da Pessoa Idosa na Atenção Básica - AMPI-AB em 100% dos idosos matriculados nas Unidades Básicas de Saúde (UBS) do município, utilizando-a como parâmetro de atenção à pessoa idosa.
11	6	Constituir equipes de gestão de alta nos 18 hospitais da Rede Municipal, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
11	7	Inaugurar 6 novas Unidades de Referência à Saúde do Idoso (URSI), na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
11	8	Adequar a infraestrutura e os recursos humanos das 10 URSI já existentes, na perspectiva da constituição das Redes de Atenção à Saúde (RAS).
11	9	Implantar 19 novas Instituições de Longa Permanência para Idosos (ILPI).
11	10	Implantar 16 novos Centros-Dia para Idosos (CDI).
11	11	Garantir que todos os equipamentos socioassistênciais para idosos de média e alta complexidade de SMADS (ILPI, CDI e Centro de Acolhida Especial para Idosos -CAE-Idosos) contenham profissionais de saúde.
11	12	Ampliar o Programa de Acompanhante de Idosos - PAI com 24 novas equipes.
11	13	Implantar serviço de monitoramento a distância em 300 Idosos com 80 anos ou mais e que moram sozinhos ou em companhia de outros (50 idosos por Coordenadoria Regional de Saúde - CRS).
11	14	Desenvolver oficinas intergeracionais nos 23 Centros de Convivência e Cooperativa (CECCO).
12	1	Utilizar um único cadastro para beneficiários dos programas de transferência de renda até dezembro de 2020.
12	2	Protocolizar, junto ao Ministério do Desenvolvimento Social e Caixa Econômica Federal, o pagamento do Renda Mínima no mesmo cartão e na mesma rotina de pagamentos do Bolsa Família.
12	3	Atingir 90% de usuários dos Serviços de Convivência e Fortalecimento de Vínculos (SCFV) inseridos no CADÚnico.
12	4	Atingir 75% de taxa de atualização cadastral do CADÚnico até 2020.
12	5	Atingir 90% de usuários dos serviços de Proteção Social Especial para idosos inseridos no CADÚnico.
30	7	Implementar novo modelo de aquisição de acervo.
13	1	Capacitar todos os profissionais atuantes nos Núcleos de Convivência de Idosos (NCI) e os responsáveis pela supervisão técnica.
13	2	Efetuar diagnóstico da rede e da territorialização dos Serviços de Convivência e Fortalecimento de Vínculos.
13	3	Reordenar a rede de Serviços de Convivência e Fortalecimento de Vínculos conforme diagnóstico efetuado.
13	4	Ampliar os Centros de Convivência Intergeracional, criando no mínimo uma unidade em cada uma das 27 Prefeituras Regionais que hoje não contam com esse serviço, através de parcerias.
14	1	Garantir o pleno funcionamento das unidades atuais, ampliando capacidade de atendimento a fim de atingir o número de 3500 concluintes.
14	2	Ampliar o número de UAPIS, de maneira a alcançar o número total de dez unidades em 2020.
14	3	Criar mecanismos de mobilização permanente para aumentar a demanda da população pelos cursos oferecidos e, consequententemente, o número de matriculados.
14	4	Criar metodologia de acompanhamento do trabalho e de satisfação dos participantes.
15	1	Implantar quatro Espaços Vida, que contarão com acessibilidade e eficiência energética.
15	2	Melhorar a infraestrutura dos demais Centros de Acolhida para adequação a padrão de qualidade considerando, dentre outras, melhorias de acessibilidade, ambiência e eficiência energética.
15	3	Criar e publicar indicadores de qualidade e efetividade do Acolhimento à População em situação de rua.
15	4	Avaliar todas as unidades de acolhimento para a população de rua conforme indicadores desenvolvidos.
15	5	Disponibilizar capacitação profissional em todos os Espaços Vida.
15	6	Garantir que todas as pessoas em situação de rua com perfil condizente com o serviço de tipo República encaminhadas pela rede de referência sejam acolhidas nesta modalidade.
15	7	Criar 9 Centros Temporários de Acolhimentos (CTA).
16	1	Garantir a participação de membros das inspetorias regionais da GCM em pelo menos um CONSEG de sua jurisdição.
16	2	Promover a Integração com a Polícia estadual.
16	3	Integrar 10.000 câmeras de videomonitoramento na cidade (city cameras), de forma a expandir o monitoramento de segurança urbana.
16	4	Implantar plataforma integrada, acessível e transparente de informações de segurança urbana, buscando integrar bancos de dados, canais de comunicação e sistemas de informação de agências de segurança das três esferas de governo atuantes no município.
16	5	Implantar um sistema inteligente de suporte à decisão em segurança urbana - “CompStat Paulistano”.
16	6	Capacitar todos agentes de segurança urbana para o uso do sistema “Compstat Paulistano”.
16	7	Implantar o Centro de Operações Integradas (COI).
16	8	Estruturar o Núcleo de Monitoramento Aéreo com Drones na SMSU.
17	1	Contratar 1500 novos agentes de segurança até 2020.
17	2	Otimizar a distribuição de atividade complementar nos dias de folga dos agentes da Guarda Civil Metropolitana de acordo com a demanda por ações de segurança.
17	3	Aumentar a relação entre o efetivo na rua e o alocado em funções administrativas.
17	4	Capacitar 500 guardas em situação de afastamento para o exercício de funções administrativas.
17	5	Diminuir os casos de afastamento de agentes da GCM por razões médicas e psicológicas.
17	6	Substituir 800 revólveres .38 em posse do efetivo da guarda civil por pistolas .380 até 2020.
17	7	Adquirir 50 motocicletas para patrulhamento da Guarda Civil Metropolitana.
18	1	Reformar e/ou realizar melhorias em pelo menos 60% (28) dos Centros Esportivos (CEs), garantindo requisitos mínimos de acessibilidade.
18	2	Realizar a campanha: “São Paulo Cidade Ativa”.
18	3	“Movimenta Sampa” - Aumentar em 30% o número de participantes nos programas de atividade física orientada.
18	4	“SampaCor” - reestruturação do calendário de corridas de rua incluindo o atual Circuito Popular de Corridas de Rua.
18	5	Ampliar em 30% o número de crianças e adolescentes participantes do Programa Clube Escola.
18	6	Reestruturar e realizar anualmente a Virada Esportiva anual com atividades atingindo todas as regiões da cidade.
18	7	Reestruturar e realizar anualmente os Jogos da Cidade.
18	8	Garantir o funcionamento de pelo menos 80 Ruas de Lazer em um novo formato que inclui o lançamento das “Ruas de lazer Musicais”.
18	9	Lançar aplicativo, garantindo ferramentas básicas de acessibilidade, que contribua para a promoção da prática da atividade física e do lazer.
18	10	Reestruturar o calendário de eventos e campeonatos realizados com apoio da secretaria e que estimulem a atividade física na cidade.
18	11	Lançar plano de melhorias de gestão e recuperação da finalidade pública dos Clubes da Comunidade (CDCs).
18	12	Lançar o Programa “Adote um Clube”.
19	1	Expandir o número de matrículas em creche por meio de organizações parceiras.
19	2	Implementar o MROSC (Marco Regulatório das Organizações da Sociedade Civil) na educação infantil.
19	3	Criar instância reguladora das parcerias realizadas para oferta do atendimento em creche.
19	4	Ampliar as matrículas de crianças cujas famílias sejam elegíveis ao Programa Bolsa Família em unidades de educação infantil.
20	1	Ofertar formação permanente em alfabetização para 100% dos professores do Ciclo de Alfabetização e de Recuperação Paralela.
20	2	Aplicar a Provinha São Paulo anualmente para todos os alunos do 2º ano do Ensino Fundamental.
20	3	Garantir a presença de um estagiário para apoio ao professor em todas as turmas do 1º ano do Ensino Fundamental.
21	1	Ofertar formação específica permanente para os professores do Ensino Fundamental II.
21	2	Ofertar formação para as equipes pedagógicas das DREs sobre organização de plano de ação e acompanhamento de aprendizagem.
21	3	Ofertar atendimento educacional especializado e garantir serviços de apoio aos alunos com deficiência, transtornos globais do desenvolvimento, altas habilidades e superdotação.
21	4	Promover apoio pedagógico nas unidades educacionais para garantia da aprendizagem dos alunos em contextos vulneráveis, com violações de direitos e/ou questões relacionadas a saúde mental.
22	1	Aplicar anualmente a Prova São Paulo a todos os alunos do 3º ao 9º ano do Ensino Fundamental.
22	2	Criar e disponibilizar a Avaliação Semestral, a partir do 3º ano, para todas as escolas de Ensino Fundamental e para a Educação de Jovens e Adultos.
22	3	Aplicar anualmente a Provinha São Paulo para todos os alunos do 2º ano do Ensino Fundamental.
22	4	Oferecer formação para equipes pedagógicas das DREs e equipes gestoras de todas as escolas de Ensino Fundamental sobre análise de dados de avaliações como subsídio ao planejamento pedagógico.
22	5	Aplicar simulado ENEM para os alunos do EM ao final de cada semestre.
23	1	Construir o Currículo da Cidade de São Paulo de forma participativa, por meio de Grupos de Trabalho, seminários e consultas à comunidade educativa e à sociedade civil.
23	2	Publicar e difundir o Currículo da Cidade de São Paulo para todos os profissionais da Rede Municipal de Ensino e para a sociedade em geral.
23	3	Formar os supervisores, diretores e coordenadores pedagógicos da Rede Municipal de Ensino para a implementação do Currículo da Cidade de São Paulo nas unidades educacionais.
23	4	Alinhar as ações de formação da Rede Municipal de Ensino ao Currículo da Cidade de São Paulo.
23	5	Alinhar as avaliações externas ao Currículo da Cidade de São Paulo.
23	6	Implementar o letramento digital em todas as unidades educacionais de ensino fundamental.
24	1	Identificar perfil dos alunos evadidos ou reprovados por frequência na Rede Municipal de Ensino.
24	2	Realizar a busca ativa de crianças e adolescentes fora da escola em idade de escolarização obrigatória.
24	3	Fortalecer mecanismos que assegurem o acompanhamento contínuo da frequência escolar pelas unidades educacionais, DREs e SME.
24	4	Criar e implementar orientação normativa intersecretarial voltada a alunos com faltas consecutivas ou baixa frequência.
24	5	Articular programas e ações de diversos órgãos municipais visando à garantia de acesso e permanência na escola.
24	6	Ofertar formação a equipes das DREs e educadores para o enfrentamento do abandono e outras formas de exclusão educacional.
25	1	Identificar ações e formações na SME e DREs, verificar a necessidade de formações específicas e realizar encontros formativos (cursos, palestras e Seminários) que trabalhem os conceitos, princípios e diretrizes da Educação Integral e da Cidade Educadora.
25	2	Instituir Grupo de Trabalho Intersecretarial e Intersetorial.
25	3	Reorganizar as normativas relativas às extensões de jornada e Educação integral em tempo integral.
25	4	Construir, aplicar e analisar Indicadores de Monitoramento, Avaliação e Aprimoramento das atividades de expansão de jornada.
25	5	Construir e publicar documento conceitual e orientador da Política São Paulo Educadora.
25	6	Publicar portaria de adesão e orientar as escolas sobre a adesão ao Programa São Paulo Integral.
25	7	Implementar turmas de Educação Integral em tempo integral nas EMEFs dos CEUs.
25	8	Ampliar o número de escolas com turmas de educação integral em tempo integral nas EMEFs.
25	9	Ampliar o número de educandos em Educação Integral em tempo integral nas EMEFs por meio das atividades de expansão da jornada.
26	1	Definir a estrutura de uso e funcionamento dos Laboratórios de Educação Digital (LEDs).
26	2	Formar equipes para gestão pedagógica e técnica dos LEDs.
26	3	Adquirir insumos e equipamentos: notebooks, dispostivos 2 em 1 (notebook/tablet) e impressoras 3D.
26	4	Implantar os LEDs nas EMEFs.
26	5	Implantar os LEDs nos CEUs.
26	6	Implementar ações pedagógicas a partir dos LEDs em todas as unidades municipais de ensino fundamental (EMEFs).
27	1	Desenhar nova topologia de rede.
27	2	Revisar e reconfigurar os atuais dispositivos de rede existentes (firewall e switches), além de servidores locais, por meio da otimização do consumo do link.
27	3	Adotar dispositivos de compressão de dados para otimização da capacidade links de comunicação.
27	4	Contratar novos de links de comunicação de dados (upgrade).
27	5	Expandir os recursos de comunicação de dados sem fio (WIFI) nas escolas.
27	6	Equipar as UEs com servidores (equipamento) para distribuição de conteúdos pedagógicos.
28	1	Elaborar um novo modelo de gestão de equipamentos culturais, com a possibilidade de estabelecer parcerias de gestão com Organizações da Sociedade Civil, Organizações Sociais e Entidades Privadas.
28	2	Elaborar um modelo de parceria que permita a cessão de uso de espaços públicos para instituições de interesse público e coletivos culturais de comprovada relevância para a realização de atividades culturais de interesse público, sobretudo em áreas com defasagem de equipamentos dessa natureza.
29	1	Realizar a requalificaçãode no mínimo 50% das Casas de Cultura.
29	2	Aumentar em 50% a quantidade de eventos oferecidos nas Casas de Cultura por meio da programação do Circuito Municipal de Cultura.
29	3	Ampliar a circulação dos artistas contratados nas Casas de Cultura, promovendo a diversificação de origem geográfica dos artistas que se apresentam em cada equipamento.
29	4	Implementar o MAR - Museu de Arte de Rua.
29	5	Criação da Escola do Grafite.
29	6	Inaugurar as Casas de Cultura de Parelheiros e de Cidade Ademar.
29	7	Realizar adequação arquitetônica de acessibilidade de forma que 75% dos equipamentos culturais de São Paulo estejam adequados até o fim da gestão.
29	8	Implantar ao menos 25 salas de cinema, priorizando os distritos que não possuem este tipo de equipamento.
29	9	Implementar o acesso à rede WiFi em todos os equipamentos culturais da SMC até 2020.
30	1	Ampliar os horários de funcionamento das 54 bibliotecas do Sistema Municipal de Bibliotecas (SMB) e garantir que 100% delas estejam abertas aos domingos.
30	2	Aumentar a programação regular, oferecendo múltiplas linguagens artísticas no equipamento.
30	3	Treinar 100% dos funcionários de atendimento de pelo menos 40 bibliotecas.
30	4	Disponibilizar WiFi em todas as unidades.
30	5	Implementar nova estratégia expositiva do acervo para facilitar o uso do público frequentador.
30	8	Garantir que, nas prefeituras regionais onde não há biblioteca do SMB, possa ser realizada uma parceria para abertura e instalação de um “Ponto de Leitura”.
30	9	Criar e implementar plano estratégico de comunicação para o Programa Biblioteca Viva.
30	10	Realizar a requalificação da infraestutura das bibliotecas que necessitarem.
31	1	Expandir em uma unidade os Centros de Cidadania LGBT.
31	2	Formar as equipes dos centros existentes em relação a melhoria de processo de aumento de eficácia no atendimento.
31	3	Divulgar trabalho dos centros com a comunidade ao seu redor por meio de oficinas temáticas e materiais de comunicação.
31	4	Implementar a Casa da Mulher Brasileira após a entrega do imóvel concluído, mobiliado e devidamente regularizado pelo governo federal.
31	5	Integrar o Transcidadania aos centros de Cidadania LGBT com objetivo de expandir o atendimento à população trans.
31	6	Ampliar em 3 unidades os Centros de Promoção da Igualdade Racial.
31	7	Realizar a manutenção e acompanhamento dos Centros de Cidadania de modo a garantir a qualidade do serviço prestado.
32	1	Criar os critérios para o Selo Voluntário Municipal de Direitos Humanos e Diversidade para Empresas.
32	2	Realizar chamada pública para fomento e incentivo de parceiros para adoção do selo anualmente (2018, 2019 e 2020).
32	3	Realizar diagnóstico do potencial de empregabilidade que o selo pode gerar com instituto de pesquisa parceiro.
32	4	Realizar evento anual sobre direitos humanos e diversidade para divulgação do selo e fomento da cultura de direitos humanos nas empresas de forma voluntária.
32	5	Realizar anualmente concurso de inscrição para empresas candidatas ao selo.
32	6	Definir e formar rede de acompanhamento das empresas aderentes ao selo.
33	1	Promover a conservação e ampliação da cobertura vegetal de parques municipais por meio de concessões e parcerias com a iniciativa privada e organizações não governamentais.
33	2	Plantar 200.000 mudas de árvore no município.
33	3	Elaborar relatório de indicadores e de sustentabilidade ambiental.
33	4	Realizar 4500 projetos educativos para a valorização e a proteção de todas as formas de vida, a fauna e a vegetação, na Cidade de São Paulo.
33	5	Instituir o Plano de Arborização Municipal, estabelecendo diretrizes para os manejos arbóreo e florestal, atualizando e mantendo o cadastramento georreferenciado da arborização municipal e implantando o monitoramento online via satélite e algoritmos.
33	6	Instituir o Plano Municipal de Áreas Protegidas, Áreas Verdes e Espaços Livres (Sistema SAPAVEL).
33	7	Plantar 175.000 árvores de pequeno porte nos terrenos de linhas de alta tensão e faixas de dutos.
33	8	Plantar 50 mil árvores por meio de doações ou parcerias.
34	1	Realizar diagnóstico aprofundado sobre a cadeia formal e informal de reciclagem da cidade de São Paulo.
34	2	Implantar programa visando o reaproveitamento de 66% dos resíduos orgânicos provenientes de podas e feiras livres.
34	3	Implantar Programa de Gestão de Resíduos Orgânicos em 1.525 escolas públicas municipais que dispoem de área disponível para compostagem.
34	4	Avaliação das cooperativas colaboradoras e credenciadas do município de São Paulo para auxiliar na tomada de decisão e formulação de ações e estratégias para o fortalecimento da rede de coleta seletiva.
34	5	Implantar programa de qualificação técnica e melhoria de gestão das cooperativas, sistema de monitoramento de sua sustentabilidade e inserção social de novos integrantes, para 2100 pessoas.
34	6	Ampliar e otimizar a coleta seletiva em São Paulo, reorganizando a área coberta pelas concessionárias e cooperativas, visando ampliar em 127% (108 mil ton) o volume coletado até 2020.
34	7	Implantar a coleta seletiva em 100% dos edifícios públicos municipais.
34	8	Assinar 3 parcerias e acordos setoriais municipais para implantação efetiva da logística reversa.
34	9	Implementar ações de educação ambiental, comunicação e integração institucional para sensibilização dos munícipes com relação aos problemas ambientais gerados pelos resíduos urbanos.
35	1	Definir uma rede de vias para o uso de pedestres, que possibilite um deslocamento seguro, acessível e a plena apropriação dos espaços públicos por todos que se locomovem a pé.
35	2	Criar manuais que definam critérios de implementação e uso para os equipamentos para pedestres.
35	3	Implementar projetos de redesenho urbano (alterações no viário, sinalização, ajardinamento, instalação de mobiliário urbano) em 10 áreas da cidade que apresentam alta prevalência de pedestres.
35	4	Criar sete rotas de calçadas ou passeios com acessibilidade e desenho universal adequadas para pessoas com deficiência física e sensorial para facilitação do acesso a equipamentos de uso intenso por esse público.
35	5	Realizar avaliação de segurança e promover adequação de geometria e sinalização em geral em oito corredores de transporte público para a melhoria das condições de segurança.
35	6	Desenvolver e implantar projetos de sinalização e operação viária em 50 vias, adequando tempos de travessia e intensificando a atenção e a orientação aos pedestres.
36	1	Implementar um programa que visa a incentivar os condutores registrados no município de São Paulo a respeitarem as normas de trânsito por meio de premiação daqueles que não forem autuados pelo período mínimo de um ano - Programa Condutor Legal.
36	2	Implementar novas ações de Educação no Trânsito para público escolar.
36	3	Implementar novas ações de Educação no Trânsito para pedestres, ciclistas e condutores.
36	4	Implementar o Programa Viagem Segura: voltado para ações de Segurança e Atendimento, visa a atualizar e reciclar os operadores do sistema de transporte público (Motoristas, Cobradores e Fiscais), aumentado suas competências para o efetivo papel que devem desenvolver no exercício de sua profissão.
36	5	Implantar interface entre Companhia de Engenharia de Tráfego e Secretaria Municipal de Saúde (pelo Serviço de Atendimento Médico de Urgência - Samu), que permita o fornecimento de dados relativos à ocorrência de acidentes de trânsito no município de São Paulo.
37	1	Realizar 4 pesquisas sobre mobilidade ativa, conforme previsto no Plano de Mobilidade de São Paulo - PlanMob (2015) e com participação das Câmaras Temáticas do Conselho Municipal de Trânsito e Transporte relacionadas.
37	2	Desenvolver e implementar ferramenta tecnológica para dispositivos móveis para provimento de informações e avaliação em tempo real, pelos usuários, de aspectos do transporte público municipal.
37	3	Desenvolver e implementar ferramenta tecnológica para dispositivos móveis para avaliação consecutiva, pelos condutores, das condições do trajeto percorrido e de elementos da operação no transporte público municipal.
37	4	Conduzir programa de residência de 70 projetos de tecnologia na área de transportes, mobilidade e segurança no trânsito.
38	1	Implementar programa de incentivo ao uso de bicicleta por meio da concessão de créditos de mobilidade - Programa Bike SP / Lei nº 16.547 de 2016.
38	2	Implantar novo sistema de compartilhamento de bicicletas, caracterizando uma efetiva integração com capilaridade e alcance pleno do território da cidade - Programa Integra-Bike São Paulo / Lei nº 16.388 de 2016.
38	3	Revisão e gestão da rede cicloviária municipal com vistas à conectividade dentro da própria malha (entre as vias cicláveis) e com os eixos do transporte coletivo, visando a atingir um índice de conectividade de 90%.
39	1	Mutirão Mário Covas - Requalificar 200.000m² de passeios públicos em rotas estratégicas através de mutirões.
39	2	Calçada Nova - Requalificar 50.000m² de passeios públicos de responsabilidade da Prefeitura (calçadas próprias) na região central.
39	3	Mapeamento das rotas estratégicas de intervenção com base nos Planos Regionais das Prefeituras Regionais e definição da Programação das intervenções para o período 2017-2020.
40	1	Construir e colocar em operação 72 Km de corredores de ônibus.
40	2	Construir e colocar em operação dois terminais de ônibus municipais.
41	1	Contratar a concessão do transporte público municipal.
41	2	Renovar a frota conforme regra contratual, respeitando a idade máxima permitida pela tecnologia e a idade média de 5 anos da frota por empresa contratada, alcançando ao menos 4.000 novos veículos.
41	3	Alcançar o número de ao menos 6.000 veículos equipados com ar condicionado, tomadas Universal Serial Bus (USB) e WiFi.
41	4	Garantir acessibilidade universal em 100% da frota de ônibus.
41	5	Aumentar em 50.000 a oferta de lugares nos ônibus no período pico da manhã.
42	1	Produzir 11.000 Unidades Habitacionais de interesse social vinculadas aos projetos de urbanização de assentamentos precários.
42	2	Produzir 2.500 Unidades Habitacionais de interesse social HIS 1 (famílias com renda até 3 salários mínimos) para atendimento da demanda aberta.
42	3	Produzir 4.000 Unidades Habitacionais de interesse social HIS 1 - Entidades e associações de moradia.
42	4	Produzir 2.500 Unidades Habitacionais de interesse social em Operações Urbanas Consorciadas.
42	5	Produzir 4.000 Unidades Habitacionais por meio de Parceria Público Privada (PPP).
42	6	Contratar a construção ou reforma de 7.500 Unidades Habitacionais a serem concluídas após 2020.
42	7	Adquirir imóveis para construção ou reforma de 10.250 Unidades Habitacionais de interesse social.
42	8	Fomentar a produção de Unidades Habitacionais de interesse social HIS 1 acima da Faixa 1 do MCMV e HIS 2 (famílias com renda até 6 salários mínimos) para atendimento de demanda aberta não contemplada na linha de ação 2.
43	1	Construir ou reformar 1.000 Unidades Habitacionais de locação social para atendimento de famílias com renda até 3 salários mínimos para ampliar as formas de acesso à moradia e à cidade, por meio da criação e gestão de parque imobiliário locatício que propicie alternativa para a redução do déficit habitacional.
44	1	Entregar títulos de garantia de posse (Concessão de Uso Especial para Fins de Moradia, Concessão de Direito Real de Uso ou de Legitimação de Posse) para 50 mil famílias.
44	2	Entregar títulos de garantia de direito de propriedade (Termos de Quitação ou Contratos de Compra e Venda) para 30 mil famílias.
44	3	Registro do parcelamento em áreas particulares para 20 mil famílias.
44	4	Registro do parcelamento em áreas públicas para 30 mil famílias.
44	5	Regularização municipal do parcelamento em áreas particulares para 60 mil famílias.
44	6	Regularização municipal do parcelamento em áreas públicas para 10 mil famílias.
44	7	Obtenção de licenciamento ambiental em áreas localizadas nas Áreas de Proteção e Recuperação de Mananciais - APRMs para 10 mil famílias.
45	1	Promover Urbanização em Assentamentos Precários para beneficiar 10.833 famílias.
45	2	Promover Urbanização em Assentamentos Precários em áreas de mananciais (Áreas Ambientalmente Frágeis e Sensíveis) para beneficiar 16.667 famílias.
46	1	Atualizar o mapeamento das áreas de risco geológico, realizados pelo IPT em 2010.
46	2	Iniciar o mapeamento dos riscos hidrológicos e tecnológicos, adequando as metodologias existentes à realidade do município, de forma a subsidiar o planejamento e implantação do processo de gerenciamento destes riscos.
46	3	Elaborar a relação de áreas prioritárias para a implantação do gerenciamento dos riscos, de forma a balizar as ações internas e, também, informar as comunidades como forma de sensibilizá-las sobre a importância da sua integração neste processo de gerenciamento.
46	4	Fortalecer os 380 Núcleos de Defesa Civil (NUDECs) existentes por meio da integração e organização das comunidades das áreas de risco a partir dos critérios de criticidade pré-estabelecidos dentro dos planos de contingências a serem implantados nas respectivas áreas.
46	5	Fomentar a criação de 350 NUDECs e integrando-os ao processo de gerenciamentos dos riscos dos riscos mapeados.
46	6	Implantar o Programa de Mobilização e capacitação para a percepção de riscos a partir das áreas priorizadas.
46	7	Implantar o Programa Saúde, Proteção e Defesa Civil na Escola e o Grupo de Defesa Civil Escola em 180 escolas articulando órgãos do Sistema Municipal de Defesa Civil e priorizando escolas municipais localizadas em áreas de risco alto e muito alto.
46	8	Elaborar 896 Planos de Contingência priorizando as áreas de riscos alto e muito alto, no caso dos geológicos e hidrológicos, e de grande vulnerabilidade no caso dos riscos tecnológicos.
52	3	Aumentar de 70 para 140 o número de produtores rurais atendidos pelo Programa de Assistência Técnica e Extensão Rural.
46	9	Implantar dentro do Sistema Municipal de Defesa Civil de um programa de controle do uso do solo devidamente organizado com vistas a coibição da implantação de futuras áreas de risco, principalmente em locais onde as características geológico-geotécnicas não sejam favoráveis, e também o fortalecimento de politicas públicas existentes com vistas ao congelamento de áreas que foram objeto de desocupações.
47	1	Elaborar 20 Planos de Bacias para o município, contendo o estudo das bacias hidrográficas e propostas de intervenção para melhoria da drenagem urbana.
47	2	Elaborar projetos de obras prioritárias de controle de cheias, garantindo a continuidade das ações de drenagem.
47	3	Promover a limpeza de 100% dos córregos nas Prefeituras Regionais identificados como prioritários por possuírem impacto na drenagem urbana.
47	4	Promover a desobstrução de 100% das galerias nas Prefeituras Regionais identificadas como prioritárias por possuírem impacto na drenagem urbana.
47	5	Promover o desassoreamento de 100% dos reservatórios de retenção nas Prefeituras Regionais conforme programação.
47	6	Aperfeiçoar o sistema de alerta a enchentes do município com a implantação de modelos de previsão de inundação em tempo real.
47	7	Implantação de intervenções de macrodrenagem na Bacia do Ribeirão Aricanduva.
47	8	Implantação de intervenções de macrodrenagem na Bacia do Riacho do Ipiranga.
47	9	Implantação de intervenções de macrodrenagem na Bacia do Córrego Uberaba.
47	10	Implantação de intervenções de macrodrenagem na Bacia do Córrego do Cordeiro.
47	11	Implantação de intervenções de macrodrenagem na Bacia do Córrego Zavuvus.
47	12	Implantação de intervenções de macrodrenagem na Bacia do Córrego Ponte Baixa.
47	13	Implantação de intervenções de macrodrenagem na Bacia do Ribeirão Perus.
47	14	Implantação de intervenções de macrodrenagem na Bacia do Córrego Tremembé.
47	15	Implantação de intervenções de macrodrenagem na Bacia do Córrego Paciência.
47	16	Implantação das intervenções do Programa de Redução de Alagamentos (PRA), destinado a obras de microdrenagem onde identificados pontos recorrentes de alagamento.
47	17	Reavaliação do sistema de drenagem da Bacia do Córrego Anhangabaú.
47	18	Implantação das intervenções em parceria com DAEE ou outros agentes.
48	1	Desenvolver um padrão de edificações de próprios públicos com dispositivos de eficiência energética e uso racional da água.
48	2	Implantar projeto piloto.
48	3	Revisar os projetos existentes (passíveis de adequação) visando a adequá-los ao novo padrão.
48	4	Desenvolver as novas demandas de projetos conforme padrão de edificação definido.
49	1	Realizar 480 vistorias em equipamentos públicos municipais antigos e emblemáticos que não atendem as normas vigentes de acessibilidade.
49	2	Produzir e lançar 2 publicações didáticas com as normas e instrumentos relativos à acessibilidade arquitetônica para apoiar os setores de Engenharia das diversas secretarias municipais.
49	3	Capacitar 2.500 agentes públicos municipais no que se refere às normas vigentes de acessibilidade.
49	4	Analisar 400 projetos arquitetônicos de reformas e construções de equipamentos públicos municipais.
49	5	Criar Comitê Intersecretarial, com participação do Conselho Municipal da Pessoa com Deficiência, para compartilhamento de informações entre Secretaria Municipal de Serviços e Obras e Secretaria Municipal da Pessoa com Deficiência relativas às obras e reformas realizadas.
49	6	Realizar 20 vistorias nas reformas, por amostragem.
49	7	Conceder - com participação do Conselho Municipal da Pessoa com Deficiência no processo de avaliação - Selo de Acessibilidade a todos os equipamentos públicos municipais reformados que atendam às normas vigentes de acessibilidade.
49	8	Produzir e lançar uma publicação (online e impressa) com os resultados do projeto, lições aprendidas e dados de monitoramento das transformações realizadas.
50	1	Revisão da Operação Urbana Centro, visando a adequá-la às diretrizes previstas no Estatuto da Cidade (Lei Federal nº 10.257/2001), com o objetivo de promover transformações urbanísticas indutoras de melhorias e a revalorização da área central, para atrair investimentos imobiliários, turísticos e culturais.
50	2	Reabilitação urbanística e readequação de espaços públicos nas imediações do Largo Coração de Jesus e Praça Julio Prestes, por meio de reforma de passeios, melhoria de iluminação pública e implantação de mobiliário urbano, em área de 38 mil m², buscando reverter o quadro de deterioração causado pela ocupação daquela região pelo “fluxo” (tráfico e consumo de drogas) e visando criar condições para a permanência de pedestres e para o desenvolvimento de atividades artísticas, de lazer e recreação.
50	3	Reforma de calçadas e calçadão no Centro Velho e Centro Novo (respectivamente nos distritos Sé e República), totalizando área de 60 mil m² promovendo a mobilidade e acessibilidade e, também, dotando aqueles espaços públicos de mobiliário urbano que propiciem o convívio social.
50	4	Requalificação do Largo do Arouche, com ações voltadas à reabilitação paisagística, reforma e ampliação dos passeios, implantação de mobiliário e equipamentos em área de 17 mil m², potencializando atividades de lazer, entretenimento, comércio e serviços.
50	5	Requalificação dos arredores do Mercado Municipal, com reformas e ampliação de passeios públicos, num total de 30 mil m², potencializando sua atratividade turística e a fruição do patrimônio histórico, no perímetro delimitado pelas ruas Barão de Duprat, Cavalheiro Basílio Jafet, Avenida do Estado, Avenida Mercúrio e Avenida Senador Queirós.
51	1	Adequar a Legislação Urbanística e Edilícia com o objetivo de regulamentar e promover a interação coerente entre os diferentes dispositivos legais.
51	2	Revisar e aprimorar os processos, com definição clara de competências e simplificação da tramitação.
51	3	Implementar o Sistema Eletrônico de Licenciamento, com a digitalização e padronização das análises conforme as adequações na legislação e tramitação dos processos.
52	1	Aumentar em 50% a captação de alimentos junto as iniciativas privadas parceiras (Supermercados, atacadistas, varejistas, etc.) e nos espaços públicos (feiras livres, mercados e sacolões).
52	2	Lançar o Plano Municipal de Desenvolvimento Rural, conforme estabelecido na Lei municipal 16.050/2014 - Plano Diretor Estratégico.
52	4	Aumentar de 250 horas/ano para 750 horas/ano o uso da Patrulha Agrícola, visando o aumento da produtividade dos produtores atendidos pelo Programa de Assistência Técnica e Extensão Rural.
52	5	Atender 16.000 pessoas com cursos e oficinas sobre educação alimentar e nutricional nos Centros de Referência em Segurança Alimentar e Nutricional.
52	6	Garantir oferta de alimentos orgânicos ou produzidos de forma agroecológica em feiras livres, mercados e sacolões, em todas as 32 regiões da cidade.
52	7	Implantar o programa de redução de desperdício de alimentos nos mercados e sacolões, administrados pela Prefeitura.
52	8	Aumentar o número de hortas urbanas atendidas pela Coordenação de Segurança Alimentar e Nutricional.
52	9	Desenvolver o Painel de Indicadores de SAN.
53	1	Aumentar o número de trabalhadores colocados no mercado de trabalho formal, via Centro de Apoio ao Trabalho e Empreendedorismo (CATe).
53	2	Redirecionar os programas operação trabalho (POT) e bolsa trabalho (BT), bem como as frentes de trabalho, para as pessoas em maior situação de vulnerabilidade e em segmentos da economia com maior probabilidade de geração de empregos.
53	3	Publicar o programa municipal de capacitação para o mundo do trabalho, conduzido pela Fundação Paulistana de Educação Tecnologia e Cultura e envolvendo atores como Comissão Municipal de Emprego, instituições de ensino públicas e privadas.
54	1	Promover 400 palestras e eventos temáticos sobre gestão, empreendedorismo e microempreendedor individual em todas as regiões da cidade.
54	2	Lançar o programa municipal de fomento ao desenvolvimento econômico envolvendo ações de atendimento às empresas com: (1) identificação das vocações regionais da cidade; (2) acesso a novos mercados, locais, regionais, estaduais, nacionais e internacionais; (3) competividade em regiões de média e alta formalidade; (4) desenvolvimento de negócios em regiões com baixa formalidade e (5) melhoria de processos, produtividade e inovação tecnológica, além de envolver os Núcleos de Desenvolvimento Regional já existentes e os que serão criados.
54	3	Criar o sistema paulistano de incubadoras de base tecnológica.
54	4	Garantir que 7000 jovens completem a capacitação inicial em economia criativa.
54	5	Implantar a incubadora escola de economia criativa.
54	6	Promover a adesão de 24 instituições ao programa pedagógico sobre empreendedorismo para instituições de ensino fundamental, médio e técnico.
54	7	Implantação do criadoemsampa.com - plataforma de fomento a empreendedores da economia criativa.
55	1	Implantar um sistema informatizado que integrará diversas bases municipais para executar os procedimentos de viabilidade, Cadastro do Contribuinte Mobiliário (CCM) e o licenciamento.
55	2	Integrar o sistema informatizado do Empreenda Fácil com o Registro e Licenciamento de Empresas (RLE), permitindo juntar os procedimentos necessários à abertura de empresas com outros entes federativos (Cadastro Nacional de Pessoa Jurídica (CNPJ), Inscrição Estadual e Número de Inscrição do Registro Empresarial (NIRE).
55	3	Renovar a rede lógica das 32 prefeituras regionais.
55	4	Ampliar o link de acesso à internet das 32 prefeituras regionais.
55	5	Renovar o parque de microcomputadores da Supervisão de Uso do Solo e Licenciamento (SUSL) das 32 Prefeituras Regionais.
55	6	Disponibilizar no site da Prefeitura de São Paulo informações sobre a utilização dos sistemas do processo integrado de abertura e formalização de empresas e materiais complementares para dúvidas e orientações.
55	7	Realizar 3 seminários para engajar as partes envolvidas (respondentes, agentes vistores, sociedade civil, equipe de licenciamento, contadores, advogados etc.).
55	8	Publicar um normativo para definir o modelo de governança e curadoria do projeto.
55	9	Adequar estruturas físicas com serviços de atendimento ao empreendedor nos territórios das 32 Prefeituras Regionais.
55	10	Fazer o atendimento a empreendedores de todos os portes, orientações para abertura de empresas de baixo risco, facilitação ao acesso de serviços de capacitação, microcrédito e acesso a mercados.
55	11	Desenvolver, com parcerias técnicas, indicador de empreendedorismo regionalizado.
55	12	Implementação do sistema automático de liberação do Cadastro de Contribuintes Mobiliários (CCM).
55	13	Implantar o Sampa.Digital - portal de acesso às compras públicas para empreendedores.
56	1	Lançar um documento com a concepção e planejamento da implantação das unidades de atendimento presencial com “padrão Poupatempo”: \na) Identificação e priorização dos serviços disponibilizados\nb) Adequação do espaço e da infraestrutura física\nc) Adequação e modernização dos recursos de teleinformática\nd) Definição do modelo de gestão das unidades de atendimento presencial e do perfil das equipes de gestão e de atendimento \ne) Concepção do programa de formação e capacitação das equipes (gestão e atendimento).
56	2	Implantar 1 unidade móvel de atendimento presencial com padrão Poupatempo.
56	3	Implantar 32 unidades de atendimento presencial com padrão Poupatempo nas regionais.
56	4	Na Política de Atendimento proposta no Projeto SP156: Canal Rápido e Direto estabelecer um padrão de qualidade Poupatempo para atendimento presencial.
56	5	Realizar programa de formação e capacitação continuada para funcionários de 2.105 postos de trabalho envolvidos.
56	6	Garantir que todo serviço prestado nas unidades de atendimento presencial com padrão Poupatempo conste no Guia de Serviços da Prefeitura e tenha prazos previamente estabelecidos.
57	1	Garantir velocidade mínima de 512kbps por usuário.
57	2	Implantar trimestralmente pesquisas de satisfação com os cidadãos.
57	3	Implantar 120 novos pontos de WiFi.
58	1	Migrar 100% dos tipos de processos administrativos hoje autuados em papel para o sistema eletrônico.
58	2	Capacitar 35.000 servidores públicos municipais para utilização do sistema.
58	3	Disponibilizar uma plataforma interna de controle gerencial dos processos para subsidiar a tomada de decisão pelos gestores municipais.
59	1	Estabelecer marco normativo que contemple diretrizes, objetivos e modalidades dos processos de desestatizações e parcerias.
59	2	Instituir o Conselho Municipal de Desestatização e Parcerias (CMDP).
59	3	Instituir o Fundo Municipal de Desenvolvimento Social.
59	4	Contratar ou receber estudos de terceiros (consultoria externa ou Procedimento de Manifestação de Interesse) para oito projetos, no âmbito do PMD.
59	5	Estruturar a viabilidade econômico-financeira e elaborar documentos editalícios de oito projetos, no âmbito do PMD, garantindo impactos sociais e econômicos, bem como melhorias de sustentabilidade ambiental e de acessibilidade.
59	6	Instaurar procedimentos formais (leilão, concorrência, chamamentos etc) de oito projetos, no âmbito do PMD.
59	7	Assinar o contrato de oito projetos, no âmbito do PMD.
60	1	Mapear de forma regionalizada as demandas de atração de investimentos internacionais para aumento de arrecadação municipal, economia de gastos dos cofres públicos e geração de trabalho e renda.
60	2	Elaborar manual de procedimentos e legislações para empresas internacionais se instalarem na cidade de São Paulo.
60	3	Realizar pelo menos 10 missões ao exterior ao ano, com objetivo de promover o intercâmbio técnico, comercial e captação de recursos internacionais para a cidade de São Paulo.
60	4	Realizar pelo menos 96 ações de projeção da cidade de São Paulo internacionalmente em cidades estratégicas, até 2020 (ações em redes de cidades, de comunicação internacional, câmaras de comércio e atividades bilaterais que promovam a cidade).
60	5	Realizar pelo menos 2 eventos internacionais coordenados pela Prefeitura de São Paulo até 2020.
60	6	Realizar pelo menos 48 ações de cooperação internacional até 2020 visando parcerias para as políticas públicas locais (intercambio de conhecimento, formação de servidores).
60	7	Desenvolver a nova marca da cidade de São Paulo junto com a sociedade civil, os empresários locais e as instituições culturais.
60	8	Realizar ações de promoção local, nacional e internacional em pelo menos 40 cidades estratégicas (ações em redes de cidades, câmaras de comércio, atividades bilaterais e ações de comunicação que promovam a cidade).
60	9	Licenciar o uso da marca.
61	1	Capacitar 30 servidores para utilização de sistemas avançados de dados (ferramentas de Business Intelligence - BI), possibilitando um melhor tratamento das informações.
61	2	Publicar Plano de Redução das Obrigações Acessórias e do Custo de Conformidade dos Contribuintes Paulistanos, o que significa reduzir burocracia e custos desnecessários e ao mesmo tempo incentivar o devido pagamento de tributos à Municipalidade, de modo que a arrecadação dos cofres públicos se aproxime do potencial que possui, sem onerar o contribuinte.
61	3	Implantação do Programa Sua Nota Vale 1 Milhão, no âmbito de reformulação da Nota Fiscal Paulistana.
62	1	Apresentar um plano de reestruturação dos passivos municipais decorrentes de precatórios judiciais.
62	2	Implementar o Sistema de Bens Patrimoniais Imóveis - SBPI.
62	3	Avaliar todos os projetos de PPPs municipais lançados, no tocante à necessidade de estruturação de garantias.
62	4	Estruturar garantias aos projetos de PPPs municipais que necessitem.
62	5	Securitizar créditos municipais decorrentes dos Programas de Parcelamentos Incentivados (PPI).
63	1	Instituir Programa dos Gestores da Economia.
63	2	Instituir Mudança no Serviço de Transporte de Pessoal.
63	3	Entregar estudo sobre as contratações dos serviços de limpeza e vigilância na cidade.
63	4	Economizar pelo menos R$ 1 milhão em suprimentos por meio de Atas de Preço e Termos de Referência Padrão.
63	5	Reduzir em pelo menos 20% os Despesas com locação de imóveis na cidade.
63	6	Migrar o Diário Oficial para formato eletrônico.
63	7	Rever a Tabela de Temporalidade (Arquivo).
63	8	Instituir Sistema de Suprimentos, Serviços e Gestão de Despesas.
64	1	Adequar o Sistema da Dívida Ativa - SDA para integração à demais plataformas.
64	2	Implementar o Núcleo de Atuação Integrada para o combate à sonegação fiscal e à inadimplência, por meio do desenvolvimento de inteligência fiscal.
64	3	Integrar o Sistema de Ações Judiciais ao sistema do Tribunal de Justiça de São Paulo.
64	4	Implantar instrumentos gerenciais no Sistema de Execuções Fiscais Digitais.
64	5	Ampliar em 50% (30.0000) o número de Certidões de Dívida Ativa protestadas.
65	1	Realizar reuniões abertas semestrais intersetoriais nas 32 Prefeituras Regionais com representantes do governo visando acolher as propostas e demandas dos munícipes.
65	2	Publicar relatórios semestrais sobre ações e obras das Prefeituras Regionais por meio eletrônico, a fim de garantir acompanhamento, fiscalização e avaliação.
65	3	Lançar edital do Programa Agentes de Governo Aberto.
65	4	Realizar oficinas do Programa Agentes de Governo Aberto nas áreas das 32 prefeituras regionais.
65	5	Implementar um plano de comunicação para ampliar e diversificar a divulgação das iniciativas de governo aberto.
65	6	Desenvolver uma rede de Governo Aberto com servidores que envolva todas as secretarias, entes e equipamentos municipais, para fomentar iniciativas transversais de governo aberto, com ao menos dois servidores por secretaria.
65	7	Criar espaço para coworking, onde jovens, startups e coletivos selecionados possam desenvolver projetos de formato colaborativo, tendo como referência o Laboratório de Mobilidade Urbana de São Paulo (MobiLab).
65	8	Realizar 22 diagnósticos setorializados para mapeamento das bases de dados produzidas, sendo 01 por cada órgão da Administração Direta.
65	9	Realização de 4 ciclos do programa de transformação de demandas sociais em dados abertos, composto por três ações encadeadas: a) análise qualitativa dos pedidos de acesso à informação para mapear informações mais pedidas e vulnerabilidades no atendimento ao e-SIC; b) realização de 06 eventos ‘LAI com Direitos Humanos e Políticas Públicas Setorais’, capacitando sociedade civil para a realização de pedidos de acesso à informação destinados a determinado assunto ou política pública; c) realização de 06 eventos ‘Café Hacker’ para que sociedade civil e empresas interessadas desenvolvam bases de dados abertas sobre determinado assunto ou política pública.
65	10	Institucionalizar Política Municipal de Transparência e Dados Abertos .
65	11	Oferecer 01 curso por trimestre de Gestão da Informação e Abertura de Dados Públicos junto à EMASP, capacitando no mínimo 120 gestores e servidores por ano.
65	12	Oferecer 01 curso por trimestre para formar agentes da sociedade civil capazes de acompanhar implementação da política de transparência e dados abertos, capacitando no mínimo 120 cidadãos por ano.
65	13	Implementar a atualização automatizada dos dados gerados pelos diferentes sistemas da Prefeitura.
66	1	Definir e publicar os critérios de acessibilidade digital da Prefeitura de São Paulo e respectivos instrumentos e processos de avaliação.
66	2	Realizar dois eventos com programadores e especialistas em acessibilidade digital.
66	3	Construir canal virtual interativo aberto à população.
66	4	Produzir e divulgar uma cartilha (impressa e virtual) difundindo os critérios de acessibilidade digital e as orientações de como atingi-los.
66	5	Realizar um piloto de revisão e reestruturação de um site municipal, a fim de que ele sirva como exemplo de boas práticas em acessibilidade digital.
66	6	Avaliar a acessibilidade digital dos sites de todas as secretarias municipais e compartilhar com elas o diagnóstico obtido e as orientações de melhoria resultantes.
66	7	Firmar parceria com pelo menos 50% das secretarias na construção e/ou revisão de sites, no que se refere às diretrizes e ferramentas de acessibilidade digital.
66	8	Ofertar a qualquer interessado cujo(s) sítio(s) eletrônico(s) atenda(m) aos requisitos estabelecidos o serviço de certificação e concessão de Selo de Acessibilidade Digital.
67	1	Desenvolver 12 Programas de Integridade: programa criado para diagnosticar vulnerabilidades, mapear processos, sugerir melhorias e a criação de indicadores, fortalecendo, assim, a gestão, as transparências ativa e passiva e a prevenção e combate à corrupção.
67	2	Formar no mínimo 300 servidores que operam o sistema de transparência passiva (SIC).
67	3	Implementar sistema de monitoramento de obras (públicas e privadas) na cidade que permita o acompanhamento e interação dos cidadãos no exercício do controle social, por meio de um sistema de reconhecimento de dados e informações.
67	4	Formar, no mínimo, 162 servidores, sendo 03 de cada órgão da Administração Direta Municipal, para desenvolvimento das Coordenadorias de Controle Interno locais, em comunicação permanente com a CGM.
67	5	Regulamentar as Unidades de Controle Interno.
67	6	Desenvolver Ouvidorias Setoriais integrada a Ouvidoria Geral em todos os órgãos da Administração por meio da formação de no mínimo 83 servidores que atuam como Pontos focais das demandas de ouvidoria.
67	7	Regulamentar Ouvidorias Setoriais.
68	1	Realizar consulta pública sobre o desenho e acessibilidade dos portais da Prefeitura de São Paulo, bem como o layout e principais links de acesso rápido para avaliação e propositura de melhorias.
68	2	Realizar uma hackatona ou café hacker para propositura aplicativos e ferramentas que promovam facilidades ao usuários dos portais da PMSP, envolvendo categorias como acessibilidade, línguas estrangeiras, pesquisa e dados abertos.
68	3	Elaborar o Plano de Comunicação Pública para a Cidade de São Paulo.
68	4	Reestruturar o Portal da Cidade de São Paulo, com boas práticas de acessibilidade, promovendo a integração dos sistemas de comunicação institucional da cidade e maior homogeneidade dos sitios da PMSP.
68	5	Dobrar o Alcance Orgânico Anual (131 mil) das publicações feitas no perfil institucional do Facebook da PMSP, por meio de publicações com conteúdo efetivamente relevante para a população, estimulando a promoção da informação pública, o diálogo e transparência das ações da prefeitura junto aos munícipes e demais interessados.
69	1	Incorporar 11 centrais telefônicas à Central SP156, facilitando o acesso aos serviços públicos.
69	2	Expandir o número de serviços online disponíveis no Portal de Atendimento SP156.
69	3	Implantar atendimento via facebook e twitter.
69	4	Lançar uma Política de Atendimento, estabelecendo padrões de qualidade no atendimento e na prestação de serviços.
69	5	Mapear e redesenhar 24 processos de serviços.
69	6	Lançar um aplicativo para que o servidor consiga tratar as demandas diretamente do seu celular.
69	7	Integrar ou absorver 10 sistemas de tecnologia da Prefeitura ao Sistema Integrado de Gestão do Relacionamento com o Cidadão (SIGRC).
69	8	Lançar boletins mensais com indicadores e dados para avaliar e aprimorar a performance dos órgãos municipais na execução dos serviços públicos.
69	9	Monitorar e melhorar a qualidade de inserção e resposta das manifestações de usuários do SUS registradas na Ouvidoria da Saúde.
70	1	Recapear 400 km de vias até 2020, atendendo a critérios técnicos e às prioridades definidas para cada prefeitura regional, em especial vias com circulação de transporte coletivo.
70	2	Prospectar parcerias para recapeamento de 200 km de vias até 2020, atendendo a critérios técnicos e às prioridades definidas para cada prefeitura regional, em especial vias com circulação de transporte coletivo.
70	3	Organizar banco de dados geográfico com informações sobre as condições do pavimento do viário municipal, incluindo os serviços de tapa-buraco executados.
70	4	Publicar Programa de Recapeamento de Longo Prazo, com foco em descentralização, articulação institucional, identificação de áreas estratégicas e ações de manutenção preventiva.
70	5	Disponibilizar as bases de dados das condições do pavimento do viário municipal e programação de recapeamento organizadas em formato de dados abertos no GeoSampa e Portal da Transparência.
71	1	Definir os eixos e marcos estratégicos, considerando a territorialização e suas necessidades específicas.
71	2	Desenvolver metodologia para realização das ações de zeladoria do Cidade Linda pelas 32 Prefeituras Regionais.
71	3	Desenvolver um plano de comunicação a fim de engajar atores: Prefeituras Regionais, Prestadores de Serviços, Voluntários da Sociedade Civil, ONGs e Empresas.
71	4	Executar: (a) manutenção de logradouros, incluindo reparo de calçadas); (b) conservação de galerias e pavimentos; (c) retirada de faixas e cartazes; (d) limpeza de monumentos; (e) recuperação de praças e canteiros, incluindo a manutenção de brinquedos e equipamentos de ginástica; (f) poda de árvore; (g) manutenção de iluminação pública; (h) reparo de sinalização de trânsito; (i) limpeza de pichações; (j) troca de lixeiras por modelos que possibilitem a separação para coleta seletiva.
\.


COMMIT;
