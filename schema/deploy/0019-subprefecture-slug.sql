-- Deploy donm:0019-subprefecture-slug to pg
-- requires: 0018-fix-subprefecture-acronym

BEGIN;

ALTER TABLE subprefecture ADD COLUMN slug text;

UPDATE subprefecture SET slug = 'supra-regional'  WHERE id = 33;
UPDATE subprefecture SET slug = 'em-definicao'  WHERE id = 35;
UPDATE subprefecture SET slug = 'sigiloso'  WHERE id = 34;
UPDATE subprefecture SET slug = 'parelheiros'  WHERE id = 19;
UPDATE subprefecture SET slug = 'mooca'  WHERE id = 18;
UPDATE subprefecture SET slug = 'penha'  WHERE id = 20;
UPDATE subprefecture SET slug = 'pinheiros'  WHERE id = 22;
UPDATE subprefecture SET slug = 'perus'  WHERE id = 21;
UPDATE subprefecture SET slug = 'santo-amaro'  WHERE id = 25;
UPDATE subprefecture SET slug = 'pirituba'  WHERE id = 23;
UPDATE subprefecture SET slug = 'sao-mateus'  WHERE id = 26;
UPDATE subprefecture SET slug = 'sao-miguel'  WHERE id = 27;
UPDATE subprefecture SET slug = 'vila-maria-vila-guilherme'  WHERE id = 29;
UPDATE subprefecture SET slug = 'se'  WHERE id = 28;
UPDATE subprefecture SET slug = 'vila-mariana'  WHERE id = 30;
UPDATE subprefecture SET slug = 'vila-prudente'  WHERE id = 31;
UPDATE subprefecture SET slug = 'ipiranga'  WHERE id = 11;
UPDATE subprefecture SET slug = 'freguesia'  WHERE id = 9;
UPDATE subprefecture SET slug = 'cidade-ademar'  WHERE id = 6;
UPDATE subprefecture SET slug = 'santana-tucuruvi'  WHERE id = 24;
UPDATE subprefecture SET slug = 'butanta'  WHERE id = 2;
UPDATE subprefecture SET slug = 'campo-limpo'  WHERE id = 3;
UPDATE subprefecture SET slug = 'capela-do-socorro'  WHERE id = 4;
UPDATE subprefecture SET slug = 'jabaquara'  WHERE id = 14;
UPDATE subprefecture SET slug = 'aricanduva'  WHERE id = 1;
UPDATE subprefecture SET slug = 'mboi-mirim'  WHERE id = 17;
UPDATE subprefecture SET slug = 'cidade-tiradentes'  WHERE id = 7;
UPDATE subprefecture SET slug = 'casa-verde-cachoeirinha'  WHERE id = 5;
UPDATE subprefecture SET slug = 'ermelino-matarazzo'  WHERE id = 8;
UPDATE subprefecture SET slug = 'guaianases'  WHERE id = 10;
UPDATE subprefecture SET slug = 'itaquera'  WHERE id = 13;
UPDATE subprefecture SET slug = 'jacana-tremembe'  WHERE id = 15;
UPDATE subprefecture SET slug = 'lapa'  WHERE id = 16;
UPDATE subprefecture SET slug = 'itaim-paulista'  WHERE id = 12;
UPDATE subprefecture SET slug = 'sapopemba'  WHERE id = 32;


ALTER TABLE subprefecture ALTER COLUMN slug SET NOT NULL;

COMMIT;
