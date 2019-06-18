-- Deploy donm:0049-add-temporary-goal-progress to pg
-- requires: 0048-secretariat

BEGIN;

ALTER TABLE goal ADD COLUMN temporary_progress INT;

COMMIT;
