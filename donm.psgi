use strict;
use warnings;

use Donm;

my $app = Donm->apply_default_middlewares(Donm->psgi_app);
$app;

