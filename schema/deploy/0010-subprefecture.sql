-- Deploy donm:0010-subprefecture to pg
-- requires: 0009-goal-biennium

BEGIN;

CREATE TABLE subprefecture (
    id serial primary key,
    acronym text,
    name text NOT NULL,
    latitude text,
    longitude text,
    "timestamp" timestamp without time zone DEFAULT now(),
    site text,
    deputy_mayor text,
    email text,
    telephone text,
    address text
);

COPY subprefecture (id, acronym, name, latitude, longitude, "timestamp", site, deputy_mayor, email, telephone, address) FROM stdin;
19	PA	Parelheiros	-23.81517	-46.73532	2015-01-27 06:59:54.456347	http://parelheiros.prefeitura.sp.gov.br	Nilton Oliveira	parelheiros@prefeitura.sp.gov.br	PABX: 5926-6500	Av. Sadamu Inoue, 5252 - CEP 04825-000\n
18	MO	Mooca	-23.551346	-46.597937	2015-01-27 06:59:54.452743	http://mooca.prefeitura.sp.gov.br	Evando Reis	moocagab@prefeitura.sp.gov.br	PABX: 2292-2122	R. Taquari, 549 - CEP 03166-000\n
20	PE	Penha	-23.518688	-46.521483	2015-01-27 06:59:54.459935	http://penha.prefeitura.sp.gov.br	Pedro Guastaferro Junior	penhanap@prefeitura.sp.gov.br	PABX: 3397-5100	R. Candapuí, 492 - CEP 03621-000\n
22	PI	Pinheiros	-23.564339	-46.703263	2015-01-27 06:59:54.467137	http://pinheiros.prefeitura.sp.gov.br	Angelo Salvador Filardo Junior	pinheiros@prefeitura.sp.gov.br	PABX: 3095-9595	Av. Nações Unidas, 7123 - CEP 05425-070\n
21	PR	Perus	-23.518688	-46.521483	2015-01-27 06:59:54.463688	http://perus.prefeitura.sp.gov.br	Carlos Roberto Massi	perus@prefeitura.sp.gov.br	PABX: 3396-8600	R. Ylídio Figueiredo, 349 - CEP 05204-020\n
25	SA	Santo Amaro	-23.6511	-46.707524	2015-01-27 06:59:54.478448	http://santoamaro.prefeitura.sp.gov.br	Valderci Malagosini Machado	santoamaro@prefeitura.sp.gov.br	PABX: 3396-6100	Praça Floriano Peixoto, 54 - CEP 04751-030\n
23	PJ	Pirituba	-23.485963	-46.719397	2015-01-27 06:59:54.471282	http://pirituba.prefeitura.sp.gov.br	Carlos Eduardo Silva Diethelm	pirituba@prefeitura.sp.gov.br	PABX: 3993-6844	Av. Dr. Felipe Pinel, 12 - CEP 02939-000\n
26	SM	São Mateus	-23.6511	-46.707524	2015-01-27 06:59:54.482369	http://saomateus.prefeitura.sp.gov.br	Fabio Santos da Silva	saomateus@prefeitura.sp.gov.br	PABX: 3397-1100	R. Ragueb Chohfi, 1.400 -  CEP 08375-000\n
27	MP	São Miguel	-23.500517	-46.451191	2015-01-27 06:59:54.486025	http://saomiguel.prefeitura.sp.gov.br	Adalberto Dias de Sousa	saomiguelpaulista@prefeitura.sp.gov.br	PABX: 2297-9200	R. Ana Flora Pinheiro de Sousa, 76 - CEP 08060-150\n
29	MG	Vila Maria Vila Guilherme	-23.501387	-46.591497	2015-01-27 06:59:54.49358	http://vilamaria-vilaguilherme.prefeitura.sp.gov.br	Gilberto Rossi	vilamariagabinete@prefeitura.sp.gov.br	PABX: 2967-8100	R.General Mendes, 111 - CEP 02127-020\n
32	SB	Sapopemba	-23.600263	-46.51282	2015-01-27 06:59:54.522405	http://www.prefeitura.sp.gov.br/cidade/secretarias/subprefeituras/sapopemba	Nereu Amaral			Av. Sapopemba, 9064 - CEP 03988-000\n
28	SE	Sé	-23.547886	-46.634732	2015-01-27 06:59:54.489781	http://se.prefeitura.sp.gov.br	Alcides Amazonas	gabinetese@prefeitura.sp.gov.br	PABX: 3397-1200	R. Álvares Penteado, 49 - CEP 01012-001\n
33	SR	Supra-regional			2015-01-27 06:59:54.527677	\N	\N	\N	\N	\N
30	VM	Vila Mariana	-23.598524	-46.649488	2015-01-27 06:59:54.497423	http://vilamariana.prefeitura.sp.gov.br	João Carlos da Silva Martins	vilamariana@prefeitura.sp.gov.br	PABX: 3397-4100	R. José de Magalhães, 500 - CEP 04026-090\n
31	VP	Vila Prudente	-23.582639	-46.560577	2015-01-27 06:59:54.501008	http://vilaprudente.prefeitura.sp.gov.br	Marcello Rinaldi	vilaprudentegabineteexp@prefeitura.sp.gov.br	PABX: 3397-0800	Avenida do Oratório, 172 - CEP 03220-000\n
11	IP	Ipiranga	-23.587567	-46.603258	2015-01-27 06:59:54.426102	http://ipiranga.prefeitura.sp.gov.br	Alcides Gaspareto Júnior	ipiranga@prefeitura.sp.gov.br	PABX: 2808-3600	R. Lino Coutinho, 444 - CEP 04207 000\n
9	FO	Freguesia	-23.476247	-46.664606	2015-01-27 06:59:54.41823	http://freguesia.prefeitura.sp.gov.br	Bruno Ghizellini Neto	freguesia@prefeitura.sp.gov.br	PABX: 3981-5000	Av. João Marcelino Branco, 95 - CEP 02610-000\n
6	AD	Cidade Ademar	-23.667083	-46.675166	2015-01-27 06:59:54.406246	http://cidadeademar.prefeitura.sp.gov.br	Francisco Lo Prete Filho	cidadeademar@prefeitura.sp.gov.br	PABX: 5670-7000	Av. Yervant Kissajikain, 416 - CEP 04657-000\n
24	ST	Santana Tucuruvi	-23.485963	-46.719397	2015-01-27 06:59:54.474774	http://santana-tucuruvi.prefeitura.sp.gov.br	Carlos Roberto Candella	santanagabinete@prefeitura.sp.gov.br	PABX: 2987-3844	Av. Tucuruvi, 808 - CEP 02304-002\n
2	BT	Butantã	-23.588369	-46.738026	2015-01-27 06:59:54.388785	http://butanta.prefeitura.sp.gov.br	Maria Rosa da Silva	butantanap@prefeitura.sp.gov.br	PABX: 3397-4600	R. Ulpiano da Costa Manso, 201 - CEP 05538-000\n
3	CL	Campo Limpo	-23.647178	-46.756453	2015-01-27 06:59:54.393471	http://campolimpo.prefeitura.sp.gov.br	Sérgio Roberto dos Santos	campolimpo@prefeitura.sp.gov.br	PABX: 3397-0500	R. Nossa Senhora do Bom Conselho, 59 - CEP 05763-470\n
4	CS	Capela Do Socorro	-23.719853	-46.701631	2015-01-27 06:59:54.397181	http://capeladosocorro.prefeitura.sp.gov.br	Cleide Pandolfi	capeladosocorro@prefeitura.sp.gov.br	PABX: 3397-2700	R. Cassiano dos Santos, 499 - CEP 04827-000\n
14	JA 	Jabaquara	-23.49402	-46.416706	2015-01-27 06:59:54.437293	http://jabaquara.prefeitura.sp.gov.br	Wander Geraldo da Silva	jabaquara@prefeitura.sp.gov.br	PABX: 3397-3200	Av. Engº Armando de Arruda Pereira, 2314 - CEP 04309-011\n
35	ED	Em Definição			2015-01-27 06:59:54.534502	\N	\N	\N	\N	\N
1	AF	Aricanduva	-23.549884	-46.536692	2015-01-27 06:59:54.382729	http://aricanduva.prefeitura.sp.gov.br	Quintino Simões Pinto	aricanduva@prefeitura.sp.gov.br	PABX: 3396-0800	R. Atucuri, 699 - CEP 03411-000\n
17	MB	Mboi Mirim	-23.667643	-46.728435	2015-01-27 06:59:54.448925	mboimirim@prefeitura.sp.gov.br	Nerilton Antonio do Amaral	mboimirim@prefeitura.sp.gov.br	PABX: 3396-8400	Av. Guarapiranga, 1265 - CEP 04902-903
7	CT	Cidade Tiradentes	-23.583831	-46.415072	2015-01-27 06:59:54.409832	http://cidadetiradentes.prefeitura.sp.gov.br	Adriana Neves da Silva Morales	tiradentes@prefeitura.sp.gov.br	PABX: 3396-0000	Estrada do Iguatemi, 2751 - CEP 08375-000\n
5	CV	Casa Verde Cachoeirinha	-23.518827	-46.667202	2015-01-27 06:59:54.40094	http://casaverde.prefeitura.sp.gov.br	Luiz Fernando Queimadelos Gomez	casaverde@prefeitura.sp.gov.br	PABX: 2813-3250	Av. Ordem e Progresso, 1001 - CEP 02518-130\n
8	EM	Ermelino Matarazzo	-23.507539	-46.480006	2015-01-27 06:59:54.414193	http://ermelinomatarazzo.prefeitura.sp.gov.br	Sandra Regina Mancilla Lourenço	ermelinomatarazzo@prefeitura.sp.gov.br	PABX: 2048-6585	Av. São Miguel, 5550 - CEP 03871-100\n
34	SG	Sigiloso	-23.546628	-46.637787	2015-01-27 06:59:54.531082	\N	\N	\N	\N	\N
10	G	Guaianases	-23.542702	-46.424817	2015-01-27 06:59:54.42177	http://guaianases.prefeitura.sp.gov.br	Roberval Dias Torres	guaianazes@prefeitura.sp.gov.br	PABX: 2557-7099	Praça de Estrada Itaquera-Guaianases, 2565 - CEP 08420-000\n
13	IQ	Itaquera	-23.536844	-46.45446	2015-01-27 06:59:54.433828	http://itaquera.prefeitura.sp.gov.br	Mauricio Luis Martins	itaqueragabinete@prefeitura.sp.gov.br	PABX: 2561-6064	R Augusto Carlos Bauman, 851 CEP: 08210-590\n
15	JT	Jaçanã Tremembé	-23.468206	-46.582182	2015-01-27 06:59:54.441691	http://jacana-tremembe.prefeitura.sp.gov.br	José Carlos Miranda	tremembe@prefeitura.sp.gov.br	PABX: 3397-1000	Av. Luis Stamatis, 300 - CEP 02260-000\n
16	LA	Lapa	-23.52247	-46.695516	2015-01-27 06:59:54.445222	http://lapa.prefeitura.sp.gov.br	Jackeline Morena de Oliveira	lapa@prefeitura.sp.gov.br	PABX: 3396-7500	Rua Guaicurus, 1000 - CEP 05033-002\n
12	IT	Itaim Paulista	-23.49402	-46.416706	2015-01-27 06:59:54.429636	http://itaimpaulista.prefeitura.sp.gov.br	Miguel Ângelo Gianetti	itaimpaulista@prefeitura.sp.gov.br	PABX: 2944-6555	Av. Marechal Tito 3012, CEP: 08115-000\n
\.


SELECT pg_catalog.setval('subprefecture_id_seq', 35, true);

ALTER TABLE region ADD CONSTRAINT subprefecture_id_fkey FOREIGN KEY (subprefecture_id) REFERENCES subprefecture(id) ;

ALTER TABLE subprefecture DROP COLUMN deputy_mayor;


COMMIT;
