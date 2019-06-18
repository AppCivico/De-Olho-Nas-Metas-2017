-- Deploy donm:0049-add-temporary-goal-progress to pg
-- requires: 0048-secretariat

BEGIN;

ALTER TABLE goal ADD COLUMN temporary_progress NUMERIC(5, 2);

UPDATE goal SET temporary_progress = 76.00 WHERE id = 4;
UPDATE goal SET temporary_progress = 72.00 WHERE id = 6;
UPDATE goal SET temporary_progress = 33.00 WHERE id = 7;
UPDATE goal SET temporary_progress = 25.00 WHERE id = 8;
UPDATE goal SET temporary_progress = 100.00 WHERE id = 9;
UPDATE goal SET temporary_progress = 56.00 WHERE id = 10;
UPDATE goal SET temporary_progress = 59.00 WHERE id = 12;
UPDATE goal SET temporary_progress = 29.00 WHERE id = 13;
UPDATE goal SET temporary_progress = 97.00 WHERE id = 16;
UPDATE goal SET temporary_progress = 7.00 WHERE id = 17;
UPDATE goal SET temporary_progress = 9.00 WHERE id = 18;
UPDATE goal SET temporary_progress = 100.00 WHERE id = 19;
UPDATE goal SET temporary_progress = 100.00 WHERE id = 20;
UPDATE goal SET temporary_progress = 100.00 WHERE id = 21;
UPDATE goal SET temporary_progress = 23.00 WHERE id = 22;
UPDATE goal SET temporary_progress = 27.00 WHERE id = 23;
UPDATE goal SET temporary_progress = 50.00 WHERE id = 24;
UPDATE goal SET temporary_progress = 11.00 WHERE id = 25;
UPDATE goal SET temporary_progress = 17.00 WHERE id = 29;
UPDATE goal SET temporary_progress = 24.00 WHERE id = 30;
UPDATE goal SET temporary_progress = 19.00 WHERE id = 31;
UPDATE goal SET temporary_progress = 18.00 WHERE id = 32;
UPDATE goal SET temporary_progress = 0.00 WHERE id = 35;
UPDATE goal SET temporary_progress = 51.00 WHERE id = 36;
UPDATE goal SET temporary_progress = 54.00 WHERE id = 38;
UPDATE goal SET temporary_progress = 100.00 WHERE id = 40;
UPDATE goal SET temporary_progress = 3.00 WHERE id = 41;
UPDATE goal SET temporary_progress = 0.00 WHERE id = 42;
UPDATE goal SET temporary_progress = 89.00 WHERE id = 43;
UPDATE goal SET temporary_progress = 6.00 WHERE id = 44;
UPDATE goal SET temporary_progress = 0.00 WHERE id = 45;
UPDATE goal SET temporary_progress = 100.00 WHERE id = 46;
UPDATE goal SET temporary_progress = 22.00 WHERE id = 49;
UPDATE goal SET temporary_progress = 28.00 WHERE id = 50;
UPDATE goal SET temporary_progress = 0.00 WHERE id = 51;
UPDATE goal SET temporary_progress = 0.00 WHERE id = 52;
UPDATE goal SET temporary_progress = 100.00 WHERE id = 53;

COMMIT;
