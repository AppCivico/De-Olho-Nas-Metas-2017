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

COMMIT;
