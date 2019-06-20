-- Deploy donm:0042-goal-additional-information to pg
-- requires: 0041-fix-uniq-goal-project

BEGIN;

CREATE TABLE goal_additional_information (
    id            SERIAL PRIMARY KEY,
    goal_id       INTEGER NOT NULL REFERENCES goal(id),
    description   TEXT NOT NULL,
    inserted_at   TIMESTAMP WITHOUT TIME ZONE,
    updated_at    TIMESTAMP WITHOUT TIME ZONE,
    UNIQUE(goal_id, description)
);

COMMIT;
