#!/usr/bin/env perl
use common::sense;
use FindBin qw($RealBin);
use lib "$RealBin/../lib";
use open ':locale';

use Donm::PlanejaSampa::Loader;
use Donm::PlanejaSampa::Worker;
use YADA;

use DDP;

my $yada = YADA->new(
    max        => 2,
    allow_dups => 0,
    timeout    => 30,
);

my $loader = Donm::PlanejaSampa::Loader->instance;

$yada->append(sub {
    Donm::PlanejaSampa::Worker->new({
        initial_url => 'http://planejasampa.prefeitura.sp.gov.br/api/metas',
        #initial_url => 'http://127.0.0.1:3000/metas',
        action      => 'index',
        retry       => 3,
    });
});

$yada->wait();

$loader->load_all();

p $yada->stats;
