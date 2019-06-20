-- Deploy donm:0045-project-additional-information to pg
-- requires: 0044-add-badge

BEGIN;

CREATE TABLE project_additional_information (
    id            SERIAL PRIMARY KEY,
    project_id    INTEGER NOT NULL REFERENCES project(id),
    description   TEXT NOT NULL,
    hash          TEXT NOT NULL,
    inserted_at   TIMESTAMP WITHOUT TIME ZONE,
    updated_at    TIMESTAMP WITHOUT TIME ZONE,
    UNIQUE(project_id, hash)
);

ALTER TABLE badge ADD UNIQUE(name);

COMMIT;
