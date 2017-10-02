-- Deploy donm:0013-trim-subprefecture-address to pg
-- requires: 0012-remove-duplicated-goal-project

BEGIN;

update subprefecture set address = regexp_replace(address, '\s+$', '') where address is not null;

COMMIT;
