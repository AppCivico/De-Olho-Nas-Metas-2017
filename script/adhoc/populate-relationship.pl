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

#my $fh = Tie::Handle::CSV->new("$RealBin/../../dataset/database.csv", header => 1);
my $fh = Tie::Handle::CSV->new("$RealBin/../../dataset/from-to.csv", header => 1);

while (my $line = <$fh>) {
    # Adicionando projeto.
    $line = { %{ $line } };

    # Verificando se todas as linhas de ação existem.
    my $action_line_ids = $line->{'ID Linha de Ação'};
    my ($action_line_id, $action_line_subid) = split m{\.}, $action_line_ids;

    my $action_line = $schema->resultset("ActionLine")->search( { 'me.id' => $action_line_id, 'me.subid' => $action_line_subid } )->next;
    if (!$action_line) {
        p $line;
        LOGDIE "action line not found.";
    }

}

close $fh or LOGDIE $!;

INFO "Fim da execução.";

