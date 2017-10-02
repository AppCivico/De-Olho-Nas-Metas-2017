-- Deploy donm:0012-remove-duplicated-goal-project to pg
-- requires: 0011-region-variable

BEGIN;

DELETE
FROM goal_project
WHERE id NOT in (
  SELECT MIN(id)
  FROM goal_project
  GROUP BY goal_id, project_id
);

COMMIT;
