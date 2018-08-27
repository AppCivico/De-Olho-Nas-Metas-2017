-- Deploy donm:0044-add-badge to pg
-- requires: 0043-project-badge

BEGIN;

INSERT INTO badge (name) VALUES ('Acessibilidade');
INSERT INTO badge (name) VALUES ('Direitos Humanos');
INSERT INTO badge (name) VALUES ('Fundo Municipal de Desenvolvimento Social');
INSERT INTO badge (name) VALUES ('Participação Popular');
INSERT INTO badge (name) VALUES ('Recursos Federais e/ou Estaduais');
INSERT INTO badge (name) VALUES ('Sustentabilidade');

COMMIT;
