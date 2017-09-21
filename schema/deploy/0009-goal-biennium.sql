-- Deploy donm:0009-goal-biennium to pg
-- requires: 0008-goal-topic

BEGIN;

ALTER TABLE goal ADD COLUMN first_biennium TEXT ;
ALTER TABLE goal ADD COLUMN second_biennium TEXT ;

CREATE TEMP TABLE goal_tmp (
    id integer not null,
    first_biennium text not null,
    second_biennium text not null
);

COPY goal_tmp (id, first_biennium, second_biennium) FROM stdin;
1	0,662	0,7
2	136,3 em 100.000	132,8 em 100.000
7	Assinatura do termo de adesão e obtenção do selo inicial	Obtenção dos selos intermediário e pleno
25	6,8 mortes/ 100.000 habitantes	6,0 mortes/ 100.000 habitantes
3	25%(210)	75%(630)
4	50 dias	30 dias
5	11 em 1.000	10,7 em 1.000
6	1500	2000
9	0,833	0,9
38	32610	70000
21	0,85	1
8	11437	15000
10	416136,31	386105,85
11	10% (VIGITEL: 35%)	20% (VIGITEL: 38,88%)
12	23% (65.500)	30% (85.500)
13	6	6,5
14	4,8	5,8
15	1) 91%\n2) 89%\n3) 88%\n4) 82%	1) 95%\n2) 95%\n3) 95%\n4) 95%
16	0,85	0,95
17	12	46
18	278	555
19	5% (168.178)	15% (504.535)
20	5% (47.606)	15% (142.820)
22	50	150
23	80 mil	200 mil
24	-112.000 toneladas	-500.000 toneladas
27	0	2.840 pax.x / hab
26	0,39	0,4269
28	0	CO2 = 15% (156.649 ton)\nMaterial particulado = 50% (37 ton)\nNOx = 40% (1.999 ton)
29	4800	25000
30	91000	210000
31	2500	27500
32	21 km² (93% da inicial)	19,1 km² (85% da inicial)
33	0	1
34	A definir	200
35	58 mil m²	145 mil m²
36	532 dias	210 dias
37	Média	Baixa
39	14.628 empresas (8%)	14.879 empresas (10%)
40	7 dias	5 dias
41	14 regionais	32 regionais
42	170 pontos	240 pontos
43	1	1
44	1750000000	5000000000
47	US$ 5,23 bilhões (4,5%)	U$S 12,84 bilhões (10%)
45	9,5% (R$ 1.230,11 per capita)	20% (R$ 1.347,52 per capita)
46	-7% (R$ 449 milhões mais correção monetária)	-20% (R$ 386 milhões mais correção monetária)
48	2918130750	6259098645
49	0,5	1
50	6,61	7,94
51	Portal = n1 + 50%\n(51.736.482 visualizações)\nSeguidores =  450k\n(Mídias sociais = n1 + 50%)	Portal = n1 + 100%\n(68.981.976 visualizações)\nSeguidores = 600k\n(Mídias sociais = n1 + 100%)
52	80 dias (-10 dias em relação a 2013-2016)	70 dias (-20 dias em relação a 2013-2016)
53	104 ações	200 ações
\.

UPDATE goal SET first_biennium = goal_tmp.first_biennium, second_biennium = goal_tmp.second_biennium FROM goal_tmp WHERE goal.id = goal_tmp.id ;

DROP TABLE goal_tmp;

ALTER TABLE goal ALTER COLUMN first_biennium SET NOT NULL;
ALTER TABLE goal ALTER COLUMN second_biennium SET NOT NULL;

COMMIT;
