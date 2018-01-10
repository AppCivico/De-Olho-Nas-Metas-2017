-- Deploy donm:0030-topic-description to pg
-- requires: 0029-subprefecture-deputy-mayor

BEGIN;

alter table topic add column description text;

update topic set description = 'Articulado em torno do objetivo comum de tornar São Paulo uma cidade diversa, que valoriza a cultura e que garanta educação de qualidade para todas e todos' where id = 1;

update topic set description = 'Articulado em torno da ideia de São Paulo como uma cidade saudável, segura e inclusiva' where id = 2;

update topic set description = 'Busca alcançar uma cidade democrática, integrada e conectada' where id = 3;

update topic set description = 'Objetiva promover São Paulo como uma metrópole global, com governo aberto e transparente, que dialoga com seus cidadãos e valoriza seus bairros, por meio de processos participativos' where id = 4;

update topic set description = 'Foi articulado em torno da ideia de uma cidade inteligente, eficiente, que gera oportunidades e simplifica a vida das pessoas' where id = 5;

alter table topic alter column description set not null;

COMMIT;
