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
    slugify(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
        . "Curabitur congue nisi sit amet tortor cursus feugiat. "
        . "Cras dictum arcu nec maximus tristique. Donec sollicitudin luctus tincidunt. "
        . "Morbi malesuada faucibus velit eu tristique. Phasellus vel cursus nulla."
    ),
    "lorem-ipsum-dolor-sit-amet-consectetur-adipiscing-elit-curabitur-congue-nisi-sit-amet-tortor-cursus",
    'slugify text'
);

done_testing();

