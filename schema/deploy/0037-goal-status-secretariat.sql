-- Deploy donm:0037-goal-status-secretariat to pg
-- requires: 0036-planejasampa-api

BEGIN;

ALTER TABLE goal ADD COLUMN secretariat TEXT;
ALTER TABLE goal ADD COLUMN status TEXT;

COMMIT;
