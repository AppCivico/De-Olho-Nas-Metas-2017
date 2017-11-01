-- Deploy donm:0026-subprefecture-telephone-mask to pg
-- requires: 0025-fix-subprefecture-action-line

BEGIN;

update subprefecture set telephone = null, email = null where id = 32;
update subprefecture set site = null where id = 17; 

update subprefecture
set telephone = replace(replace(telephone, 'PABX: ', '+5511'), '-', '')
where telephone is not null;

COMMIT;
