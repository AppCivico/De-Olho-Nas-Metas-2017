#!/bin/bash
cp Makefile.PL docker/Makefile_local.PL

docker build -t appcivico/donm2017 docker/
