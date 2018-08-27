-- Deploy donm:0046-project-budget-execution to pg
-- requires: 0045-project-additional-information

BEGIN;

CREATE TABLE project_budget_execution (
    id                         SERIAL PRIMARY KEY,
    project_id                 INTEGER NOT NULL REFERENCES project(id),
    year                       INTEGER NOT NULL,
    own_resources_investment   TEXT NOT NULL,
    own_resources_costing      TEXT NOT NULL,
    own_resources_total        TEXT NOT NULL,
    other_resources_investment TEXT NOT NULL,
    other_resources_costing    TEXT NOT NULL,
    other_resources_total      TEXT NOT NULL,
    total_year_investment      TEXT NOT NULL,
    total_year_costing         TEXT NOT NULL,
    total_year_total           TEXT NOT NULL, 
    updated_at  TIMESTAMP WITHOUT TIME ZONE,
    UNIQUE(project_id, year)
);

COMMIT;
