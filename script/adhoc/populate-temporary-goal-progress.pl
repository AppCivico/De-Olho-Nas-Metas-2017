#!/usr/bin/env perl
use common::sense;
use open ":locale";
use FindBin qw($RealBin $Script);
use lib "$RealBin/../../lib";

use DDP;
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

my $fh = Tie::Handle::CSV->new("$RealBin/../../dataset/Análise_PDM_2017_2018 - Planilha1.csv", header => 1);

while (my $row = <$fh>) {
    my $goal_id = $row->{Meta};
    my $progress = $row->{Atingimento};
    next if not $progress =~ m{^[0-9]+%?$};

    printf "UPDATE goal SET temporary_progress = %.2f WHERE id = %d;\n", $progress, $goal_id;
}

close $fh or LOGDIE $!;

INFO "Fim da execução.";

