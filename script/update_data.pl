#!/usr/bin/env perl
use common::sense;
use FindBin qw($RealBin);
use lib "$RealBin/../lib";

use Donm::PlanejaSampa;

Donm::PlanejaSampa->new()->synchronize();
