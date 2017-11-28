-- Deploy donm:0031-fix-variable-typo to pg
-- requires: 0030-topic-description

BEGIN;

update variable set name = 'Número total de museus' where id = 555;

COMMIT;
