-- Deploy donm:0001-topic to pg
-- requires: 0000-region

BEGIN;

create table topic (
    id serial primary key,
    name text not null unique
);

COPY topic (id, name) FROM stdin;
1	Desenvolvimento Humano
2	Desenvolvimento Social
3	Desenvolvimento Urbano E Meio Ambiente
4	Desenvolvimento Institucional
5	Desenvolvimento Econômico E Gestão
\.

SELECT pg_catalog.setval('topic_id_seq', 5, true);

COMMIT;
