#!/usr/bin/env perl
use common::sense;
use open ":locale";
use FindBin qw($RealBin $Script);
use lib "$RealBin/../../lib";

use DDP;
use Fcntl ":seek";
use Text::CSV;
use Tie::Handle::CSV;
use Donm::SchemaConnected;
use Log::Log4perl qw(:easy);

# Log.
Log::Log4perl->easy_init({
    file   => "STDOUT",
    layout => '[%d] [%p] %m%n',
    level  => $DEBUG,
    utf8   => 1,
}, {
    file   => ">>$RealBin/../../log/$Script.log",
    layout => '[%d] %m%n',
    level  => $DEBUG,
    utf8   => 1,
});

INFO "Iniciando $Script...";

my $schema = get_schema();

my $fh = Tie::Handle::CSV->new("$RealBin/../../dataset/database.csv", header => 1);
#seek($fh, 0, SEEK_SET) or LOGDIE $!;

while (my $line = <$fh>) { }

seek($fh, 0, SEEK_SET) or LOGDIE $!;
<$fh>;

close $fh or LOGDIE $!;

INFO "Fim da execução.";

