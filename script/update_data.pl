#!/usr/bin/env perl
use common::sense;
use FindBin qw($RealBin);
use lib "$RealBin/../lib";

use Donm::PlanejaSampa;

exit Donm::PlanejaSampa->new()->synchronize;
