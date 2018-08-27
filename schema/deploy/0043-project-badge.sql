-- Deploy donm:0043-project-badge to pg
-- requires: 0042-goal-additional-information

BEGIN;

CREATE TABLE project_badge (
    id         SERIAL PRIMARY KEY,
    project_id INTEGER NOT NULL REFERENCES project(id),
    badge_id   INTEGER NOT NULL REFERENCES badge(id),
    updated_at TIMESTAMP WITHOUT TIME ZONE,
    UNIQUE(project_id, badge_id)
);

ALTER TABLE goal_badge    DROP CONSTRAINT goal_badge_badge_id_fkey;
ALTER TABLE project_badge DROP CONSTRAINT project_badge_badge_id_fkey;

ALTER TABLE badge RENAME TO badge_old;
ALTER TABLE badge_old DROP CONSTRAINT badge_pkey;
ALTER TABLE badge_old DROP COLUMN id;

CREATE TABLE badge ( LIKE badge_old INCLUDING ALL );
ALTER TABLE badge ADD COLUMN id SERIAL PRIMARY KEY;
ALTER TABLE badge ADD COLUMN updated_at TIMESTAMP WITHOUT TIME ZONE;

INSERT INTO badge (name) SELECT name FROM badge_old;
DROP TABLE badge_old;

ALTER TABLE goal_badge ADD CONSTRAINT goal_badge_badge_id_fkey FOREIGN KEY(badge_id) REFERENCES badge(id);
ALTER TABLE project_badge ADD CONSTRAINT project_badge_badge_id_fkey FOREIGN KEY(badge_id) REFERENCES badge(id);

COMMIT;
