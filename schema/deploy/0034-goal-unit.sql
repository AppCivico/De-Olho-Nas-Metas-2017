-- Deploy donm:0034-goal-unit to pg
-- requires: 0033-project-results-scenario

BEGIN;

ALTER TABLE goal ADD COLUMN unit_measurement TEXT CHECK(unit_measurement::text = ANY(ARRAY['R$', '%', 'unit']));

UPDATE goal SET unit_measurement = '%' WHERE id = 1;
UPDATE goal SET unit_measurement = 'unit' WHERE id = 6;
UPDATE goal SET unit_measurement = 'unit' WHERE id = 8;
UPDATE goal SET unit_measurement = '%' WHERE id = 9;
UPDATE goal SET unit_measurement = 'unit' WHERE id = 13;
UPDATE goal SET unit_measurement = 'unit' WHERE id = 14;
UPDATE goal SET unit_measurement = '%' WHERE id = 16;
UPDATE goal SET unit_measurement = 'unit' WHERE id = 17;
UPDATE goal SET unit_measurement = 'unit' WHERE id = 18;
UPDATE goal SET unit_measurement = '%' WHERE id = 21;
UPDATE goal SET unit_measurement = 'unit' WHERE id = 22;
UPDATE goal SET unit_measurement = '%' WHERE id = 26;
UPDATE goal SET unit_measurement = 'unit' WHERE id = 29;
UPDATE goal SET unit_measurement = 'unit' WHERE id = 30;
UPDATE goal SET unit_measurement = 'unit' WHERE id = 31;
UPDATE goal SET unit_measurement = '%' WHERE id = 33;
UPDATE goal SET unit_measurement = 'unit' WHERE id = 38;
UPDATE goal SET unit_measurement = '%' WHERE id = 43;
UPDATE goal SET unit_measurement = 'R$' WHERE id = 44;
UPDATE goal SET unit_measurement = 'R$' WHERE id = 48;
UPDATE goal SET unit_measurement = '%' WHERE id = 49;

ALTER TABLE goal RENAME COLUMN unit_measurement TO unit ;

COMMIT;
