-- Deploy donm:0019-fix-action-line-id to pg
-- requires: 0018-fix-subprefecture-acronym

BEGIN;

alter table action_line rename column id to project_id ;

alter table action_line rename to action_line_tmp ;

create table action_line as select * from action_line_tmp with no data;

alter table action_line add constraint project_id_fkey foreign key (project_id) references project(id) ;
alter table action_line rename column subid to id_reference ;
alter table action_line add column id serial primary key;

insert into action_line (project_id, id_reference, title, indicator_description, achievement) select * from action_line_tmp ;

alter table action_line alter column project_id set not null;

drop table project_action_line ;
drop table action_line_tmp;

COMMIT;
