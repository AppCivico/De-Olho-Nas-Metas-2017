-- Deploy donm:0022-subprefecture-fix to pg
-- requires: 0021-subprefecture-action-line

BEGIN;

UPDATE region SET subprefecture_id = 32 WHERE id = 658;

COMMIT;
