-- Deploy donm:0018-fix-subprefecture-acronym to pg
-- requires: 0017-aciton-line-indicator-achievement

BEGIN;

UPDATE subprefecture SET acronym = TRIM(acronym);
UPDATE subprefecture SET acronym = 'SP' where name = 'Sapopemba';

COMMIT;
