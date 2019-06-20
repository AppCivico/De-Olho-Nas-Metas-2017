-- Deploy donm:0041-fix-uniq-goal-project to pg
-- requires: 0040-add-badge

BEGIN;

DELETE FROM goal_project a
USING goal_project b
WHERE a.id < b.id
  AND a.goal_id = b.goal_id
  AND a.project_id = b.project_id;


ALTER TABLE goal_project ADD UNIQUE(goal_id, project_id);

COMMIT;
