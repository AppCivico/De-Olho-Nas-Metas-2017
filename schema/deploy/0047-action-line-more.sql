-- Deploy donm:0047-action-line-more to pg
-- requires: 0046-project-budget-execution

BEGIN;

ALTER TABLE badge DROP COLUMN id_old;
ALTER TABLE action_line ADD COLUMN indicator TEXT;
ALTER TABLE action_line ADD COLUMN status TEXT;
ALTER TABLE action_line ADD COLUMN last_updated_at TIMESTAMP WITHOUT TIME ZONE;

CREATE TABLE action_line_execution (
    id                       SERIAL PRIMARY KEY,
    action_line_project_id   INTEGER NOT NULL,
    action_line_id_reference INTEGER NOT NULL,
    value                    TEXT NOT NULL,
    period                   INTEGER NOT NULL,
    accumulated              BOOLEAN NOT NULL,
    updated_at               TIMESTAMP WITHOUT TIME ZONE,
    FOREIGN KEY(action_line_project_id, action_line_id_reference) REFERENCES action_line(project_id, id_reference),
    UNIQUE(action_line_project_id, action_line_id_reference, period, accumulated)
);

CREATE TABLE action_line_execution_subprefecture (
    id                       SERIAL PRIMARY KEY,
    action_line_project_id   INTEGER NOT NULL,
    action_line_id_reference INTEGER NOT NULL,
    subprefecture_id         INTEGER NOT NULL REFERENCES subprefecture(id),
    value                    TEXT NOT NULL,
    period                   INTEGER NOT NULL,
    updated_at               TIMESTAMP WITHOUT TIME ZONE,
    FOREIGN KEY(action_line_project_id, action_line_id_reference) REFERENCES action_line(project_id, id_reference),
    UNIQUE(action_line_project_id, action_line_id_reference, subprefecture_id, period)
);

COMMIT;
