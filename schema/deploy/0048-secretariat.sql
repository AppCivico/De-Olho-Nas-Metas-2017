-- Deploy donm:0048-secretariat to pg
-- requires: 0047-action-line-more

BEGIN;

CREATE TABLE secretariat (
    id   SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

INSERT INTO secretariat (name)
VALUES
  ('Controladoria Geral do Município - Secretaria Municipal de Justiça'),
  ('Secretaria do Governo Municipal'),
  ('Secretaria Municipal da Fazenda'),
  ('Secretaria Municipal da Pessoa com Deficiência'),
  ('Secretaria Municipal da Saúde'),
  ('Secretaria Municipal das Prefeituras Regionais'),
  ('Secretaria Municipal de Assistência e Desenvolvimento Social'),
  ('Secretaria Municipal de Cultura'),
  ('Secretaria Municipal de Desestatização e Parcerias'),
  ('Secretaria Municipal de Direitos Humanos e Cidadania'),
  ('Secretaria Municipal de Educação'),
  ('Secretaria Municipal de Esportes e Lazer'),
  ('Secretaria Municipal de Gestão'),
  ('Secretaria Municipal de Habitação'),
  ('Secretaria Municipal de Inovação e Tecnologia'),
  ('Secretaria Municipal de Justiça'),
  ('Secretaria Municipal de Mobilidade e Transportes'),
  ('Secretaria Municipal de Relações Internacionais'),
  ('Secretaria Municipal de Segurança Urbana'),
  ('Secretaria Municipal de Serviços e Obras'),
  ('Secretaria Municipal de Urbanismo e Licenciamento'),
  ('Secretaria Municipal do Trabalho e Empreendedorismo'),
  ('Secretaria Municipal do Verde e do Meio Ambiente');

ALTER TABLE goal ADD COLUMN secretariat_id INTEGER REFERENCES secretariat(id);

UPDATE goal
SET secretariat_id = secretariat.id
FROM secretariat
WHERE goal.secretariat = secretariat.name;

ALTER TABLE goal DROP COLUMN secretariat;

CREATE TABLE project_secretariat (
    id             SERIAL PRIMARY KEY,
    project_id     INTEGER NOT NULL REFERENCES project(id),
    secretariat_id INTEGER NOT NULL REFERENCES secretariat(id),
    updated_at     TIMESTAMP WITHOUT TIME ZONE,
    UNIQUE(project_id, secretariat_id)
);

COMMIT;

