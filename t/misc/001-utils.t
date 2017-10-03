use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";

use Test::More;

use_ok "Donm::Utils";

is( slugify("o açucar faz mal à saude"), "o-acucar-faz-mal-a-saude", 'slugify accents' );
is( slugify("#EstadoDeSãoPaulo"), "estadodesaopaulo", 'slugify hashtags' );
is( slugify("quando   houver  muitos     espaços"), "quando-houver-muitos-espacos", 'slugify spaces' );
is( slugify("o ano de 2018 será próspero!"), "o-ano-de-2018-sera-prospero", 'slugify digits' );
is(
    slugify("um texto suficientemente grande precisa ser cortada para que as urls não fiquem grandes"),
    "um-texto-suficientemente-grande-precisa-ser-cortada-para-que",
    'slugify substr'
);

done_testing();

