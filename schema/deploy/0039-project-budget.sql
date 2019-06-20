-- Deploy donm:0039-project-budget to pg
-- requires: 0038-fix-action-line-slug

BEGIN;

ALTER TABLE goal ADD COLUMN last_updated_at TIMESTAMP WITHOUT TIME ZONE;

ALTER TABLE project ADD COLUMN budget_own_resources_investment TEXT;
ALTER TABLE project ADD COLUMN budget_own_resources_costing TEXT;
ALTER TABLE project ADD COLUMN budget_other_resources_investment TEXT;
ALTER TABLE project ADD COLUMN budget_other_resources_costing TEXT;

COMMIT;
