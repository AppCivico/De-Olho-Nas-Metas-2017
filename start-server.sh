#!/bin/bash
source /home/app/perl5/perlbrew/etc/bashrc

mkdir -p /data/log/;

cd /src;
source envfile.sh

cpanm -n . --installdeps
sqitch deploy -t $SQITCH_DEPLOY

start_server \
  --pid-file=/tmp/start_server.pid \
  --signal-on-hup=QUIT \
  --kill-old-delay=10 \
  --port=$API_PORT \
  -- starman \
  -I/src/lib \
  --workers $API_WORKERS \
  --error-log /data/log/starman.log \
  --user app --group app donm.psgi
