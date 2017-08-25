#!/bin/bash -e
if [ -d "script" ]; then
  cd script;
fi

source ../envfile.sh ;

perl donm_create.pl model DB DBIC::Schema Donm::Schema create=static components=TimeStamp,PassphraseColumn "dbi:Pg:dbname=$POSTGRESQL_DBNAME;host=$POSTGRESQL_HOST" $POSTGRESQL_USER $POSTGRESQL_PASSWORD quote_names=1 overwrite_modifications=1

cd ..;
rm -f lib/Libre/Model/DB.pm.new;
rm -f t/model_DB.t;
rm -f t/model_DB.t.new;
