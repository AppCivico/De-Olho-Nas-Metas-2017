-- Deploy donm:0036-planejasampa-api to pg
-- requires: 0035-iota-indicators

BEGIN;

UPDATE topic SET name = 'Desenvolvimento Urbano e Meio Ambiente' WHERE id = 3;
UPDATE topic SET name = 'Desenvolvimento Econômico e Gestão' WHERE id = 5;

ALTER TABLE project ADD COLUMN updated_at TIMESTAMP WITHOUT TIME ZONE;

ALTER TABLE goal RENAME COLUMN first_biennium TO projection_first_biennium;
ALTER TABLE goal RENAME COLUMN second_biennium TO projection_second_biennium;

ALTER TABLE goal ADD COLUMN base_value TEXT;
ALTER TABLE goal ADD COLUMN updated_at TIMESTAMP WITHOUT TIME ZONE;

ALTER TABLE action_line ADD COLUMN updated_at TIMESTAMP WITHOUT TIME ZONE;
ALTER TABLE action_line ADD UNIQUE(id_reference, project_id);

CREATE TABLE goal_execution (
    id          SERIAL PRIMARY KEY,
    goal_id     INTEGER NOT NULL REFERENCES goal(id),
    period      INTEGER NOT NULL,
    value       TEXT NOT NULL,
    accumulated BOOLEAN NOT NULL,
    updated_at  TIMESTAMP WITHOUT TIME ZONE,
    UNIQUE(goal_id, period, accumulated)
);

COMMIT;
