-- Deploy donm:0029-subprefecture-deputy-mayor to pg
-- requires: 0028-region-variable-value

BEGIN;

alter table subprefecture add column deputy_mayor text; 

update subprefecture set deputy_mayor = 'Luiz Carlos Frigerio' where id = 1;
update subprefecture set deputy_mayor = 'Paulo Vitor Sapienza' where id = 2;
update subprefecture set deputy_mayor = 'Heitor Sertão' where id = 3;
update subprefecture set deputy_mayor = 'João Batista de Santiago' where id = 4;
update subprefecture set deputy_mayor = 'Paulo Cahim' where id = 5;
update subprefecture set deputy_mayor = 'Júlio César Carreiro' where id = 6;
update subprefecture set deputy_mayor = 'Oziel Evangelista de Souza' where id = 7;
update subprefecture set deputy_mayor = 'Arthur Xavier' where id = 8;
update subprefecture set deputy_mayor = 'Roberto de Godoi Carneiro' where id = 9;
update subprefecture set deputy_mayor = 'Antonio Eduardo dos Santos' where id = 10;
update subprefecture set deputy_mayor = 'Amandio Martins' where id = 11;
update subprefecture set deputy_mayor = 'José Denycio Pontes Agostinho' where id = 12;
update subprefecture set deputy_mayor = 'Jacinto Reyes' where id = 13;
update subprefecture set deputy_mayor = 'Maria de Fátima Marques Fernandes' where id = 14;
update subprefecture set deputy_mayor = 'Alexandre Baptista Pires' where id = 15;
update subprefecture set deputy_mayor = 'Carlos Eduardo Baptista Fernandes' where id = 16;
update subprefecture set deputy_mayor = 'Rita de Cassia Correa Madureira' where id = 17;
update subprefecture set deputy_mayor = 'Paulo Sergio Criscuolo' where id = 18;
update subprefecture set deputy_mayor = 'Adailson de Oliveira' where id = 19;
update subprefecture set deputy_mayor = 'Fernanda Maria de Lima Galdino' where id = 20;
update subprefecture set deputy_mayor = 'Luciana Torralles Ferreira' where id = 21;
update subprefecture set deputy_mayor = 'Paulo Mathias de Tarso' where id = 22;
update subprefecture set deputy_mayor = 'Ivan Renato Lima' where id = 23;
update subprefecture set deputy_mayor = 'Rosmary Correia' where id = 24;
update subprefecture set deputy_mayor = 'Francisco Roberto Arantes' where id = 25;
update subprefecture set deputy_mayor = 'Fernando Elias Alves de Melo ' where id = 26;
update subprefecture set deputy_mayor = 'Edson Marques Pereira' where id = 27;
update subprefecture set deputy_mayor = 'Eduardo Odloak' where id = 28;
update subprefecture set deputy_mayor = 'Dário José Barreto' where id = 29;
update subprefecture set deputy_mayor = 'Benedito Mascarenhas Loureiro' where id = 30;
update subprefecture set deputy_mayor = 'Guilherme Kopke Brito' where id = 31;
update subprefecture set deputy_mayor = 'Benedito Gonçalves Pereira', telephone = '+551127051092' where id = 32;


COMMIT;
