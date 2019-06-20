-- Deploy donm:0040-add-badge to pg
-- requires: 0039-project-budget

BEGIN;

CREATE TABLE badge (
    id   INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);

INSERT INTO badge (id, name)
VALUES
  (1, 'Erradicação da pobreza'),
  (2, 'Erradicação da fome'),
  (3, 'Saúde de qualidade'),
  (4, 'Educação de Qualidade'),
  (5, 'Igualdade de Gênero'),
  (8, 'Empregos dignos e crescimento econômico'),
  (9, 'Inovação e infraestrutura'),
  (10, 'Redução das desigualdades'),
  (11, 'Cidades e comunidades sustentáveis'),
  (12, 'Consumo responsável'),
  (15, 'Vida sobre a terra'),
  (16, 'Paz e justiça'),
  (17, 'Parcerias pelas metas')
;

CREATE TABLE goal_badge (
    id         SERIAL PRIMARY KEY,
    goal_id    INTEGER NOT NULL REFERENCES goal(id),
    badge_id   INTEGER NOT NULL REFERENCES badge(id),
    updated_at TIMESTAMP WITHOUT TIME ZONE,
    UNIQUE(goal_id, badge_id)
);

COMMIT;
