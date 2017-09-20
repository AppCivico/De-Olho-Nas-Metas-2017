-- Deploy donm:0008-goal-topic to pg
-- requires: 0007-project-action-line

BEGIN;

ALTER TABLE goal ADD COLUMN topic_id INTEGER REFERENCES topic(id);

UPDATE goal SET topic_id = 2 WHERE id = 1;
UPDATE goal SET topic_id = 2 WHERE id = 2;
UPDATE goal SET topic_id = 2 WHERE id = 3;
UPDATE goal SET topic_id = 2 WHERE id = 4;
UPDATE goal SET topic_id = 2 WHERE id = 5;
UPDATE goal SET topic_id = 2 WHERE id = 6;
UPDATE goal SET topic_id = 2 WHERE id = 7;
UPDATE goal SET topic_id = 2 WHERE id = 8;
UPDATE goal SET topic_id = 2 WHERE id = 9;
UPDATE goal SET topic_id = 2 WHERE id = 10;
UPDATE goal SET topic_id = 2 WHERE id = 11;
UPDATE goal SET topic_id = 1 WHERE id = 12;
UPDATE goal SET topic_id = 1 WHERE id = 13;
UPDATE goal SET topic_id = 1 WHERE id = 14;
UPDATE goal SET topic_id = 1 WHERE id = 15;
UPDATE goal SET topic_id = 1 WHERE id = 16;
UPDATE goal SET topic_id = 1 WHERE id = 17;
UPDATE goal SET topic_id = 1 WHERE id = 18;
UPDATE goal SET topic_id = 1 WHERE id = 19;
UPDATE goal SET topic_id = 1 WHERE id = 20;
UPDATE goal SET topic_id = 1 WHERE id = 21;
UPDATE goal SET topic_id = 1 WHERE id = 22;
UPDATE goal SET topic_id = 3 WHERE id = 23;
UPDATE goal SET topic_id = 3 WHERE id = 24;
UPDATE goal SET topic_id = 3 WHERE id = 25;
UPDATE goal SET topic_id = 3 WHERE id = 26;
UPDATE goal SET topic_id = 3 WHERE id = 27;
UPDATE goal SET topic_id = 3 WHERE id = 28;
UPDATE goal SET topic_id = 3 WHERE id = 29;
UPDATE goal SET topic_id = 3 WHERE id = 30;
UPDATE goal SET topic_id = 3 WHERE id = 31;
UPDATE goal SET topic_id = 3 WHERE id = 32;
UPDATE goal SET topic_id = 3 WHERE id = 33;
UPDATE goal SET topic_id = 2 WHERE id = 34;
UPDATE goal SET topic_id = 3 WHERE id = 35;
UPDATE goal SET topic_id = 3 WHERE id = 36;
UPDATE goal SET topic_id = 5 WHERE id = 37;
UPDATE goal SET topic_id = 5 WHERE id = 38;
UPDATE goal SET topic_id = 5 WHERE id = 39;
UPDATE goal SET topic_id = 5 WHERE id = 40;
UPDATE goal SET topic_id = 5 WHERE id = 41;
UPDATE goal SET topic_id = 5 WHERE id = 42;
UPDATE goal SET topic_id = 5 WHERE id = 43;
UPDATE goal SET topic_id = 5 WHERE id = 44;
UPDATE goal SET topic_id = 5 WHERE id = 45;
UPDATE goal SET topic_id = 5 WHERE id = 46;
UPDATE goal SET topic_id = 4 WHERE id = 47;
UPDATE goal SET topic_id = 4 WHERE id = 48;
UPDATE goal SET topic_id = 4 WHERE id = 49;
UPDATE goal SET topic_id = 4 WHERE id = 50;
UPDATE goal SET topic_id = 4 WHERE id = 51;
UPDATE goal SET topic_id = 4 WHERE id = 52;
UPDATE goal SET topic_id = 4 WHERE id = 53;

ALTER TABLE goal ALTER COLUMN topic_id SET NOT NULL ;

COMMIT;
