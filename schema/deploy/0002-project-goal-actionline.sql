-- Deploy donm:0002-project-goal-actionline to pg
-- requires: 0001-topic

BEGIN;

create table project (
    id    integer primary key,
    title text not null
);

create table goal (
    id    integer primary key,
    title text not null
);

create table action_line (
    id    integer not null,
    subid integer not null,
    title text not null,
    PRIMARY KEY(id, subid)
);

COMMIT;
