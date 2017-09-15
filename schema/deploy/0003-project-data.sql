-- Deploy donm:0003-project-data to pg
-- requires: 0002-project-goal-actionline

BEGIN;

COPY project (id, title) FROM stdin;
1	Amplia Saúde
2	Viver Mais e Melhor
3	Vida Urgente
4	Saúde Digital
5	Qualifica Saúde
6	#AceleraSaúde - Corujão da Saúde
7	Viva a Criança
8	Redenção
9	Trabalho Novo
10	Direitos Humanos na Cidade
11	Cidade Amiga do Idoso
12	CadMais SP
13	Longevidade
14	Universidade Aberta da Pessoa Idosa
15	Espaços Vida
16	Segurança Inteligente
17	Cidade Segura
18	São Paulo Cidade Ativa
19	Nossa Creche
20	Alfabetização
21	Apoio Pedagógico
22	Avaliação Externa
23	Currículo da Cidade de São Paulo
24	Acesso e Permanência
25	São Paulo Educadora
26	CEU 21
27	Escola Digital
28	Cultura em Parceria
29	Cultura Sampa
30	Biblioteca Viva
31	Centros de Cidadania
32	Selo de Direitos Humanos e Diversidade
33	Sampa Verde
34	Recicla Sampa
35	Pedestre Seguro
36	Trânsito Seguro
37	Ciclomobilidade
38	Mutirão Mário Covas e Calçada Nova
39	Mobilidade Inteligente
40	Cidade Conectada
41	Transporte Meu
42	Casa da Família
43	Construção ou reforma de Unidades Habitacionais para locação social
44	Programa de Regularização Fundiária
45	Urbanização Integrada em Assentamentos Precários
46	Cidade Resiliente
47	Controle de Cheias
48	Sustentabilidade das Edificações
49	Cidade Acessível
50	Centro Lindo
51	Licença Rápida
52	Alimentando SP
53	Trabalho, Emprego e Renda
54	São Paulo Criativa
55	Empreenda Fácil
56	Descomplica SP
57	WiFi SP
58	São Paulo Digital
59	Plano Municipal de Desestatização
60	São Paulo Cidade do Mundo
61	Combate à Sonegação Fiscal
62	Orçamento Sustentável
63	Gestores da Economia
64	São Paulo Sem Dívida Ativa
65	São Paulo Aberta
66	Acessibilidade Digital
67	São Paulo Íntegra e Transparente
68	Comunica SP
69	SP 156 Canal Rápido e Direto
70	Asfalto Novo
71	Cidade Linda
\.

COMMIT;
