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

my $fh = Tie::Handle::CSV->new("$RealBin/../../dataset/linhas-de-acao-regionalizadas.csv", header => 1);

$schema->txn_do(sub {
    while (my $line = <$fh>) {
        my $subprefecture_name = $line->{'Região'};

        if ($subprefecture_name eq "A definir") {
            $subprefecture_name = "A definir (ED)";
        }
        elsif($subprefecture_name eq "Supraregional") {
            $subprefecture_name = "Supraregional (SR)";
        }

        # Obtendo o result 'subprefecture' a partir do acrônimo.
        if ($subprefecture_name =~ m{\(([A-Z]{1,2})\)$}) {
            my $subprefecture_acronym = $1;

            my $subprefecture = $schema->resultset('Subprefecture')->search(
                { 'me.acronym' => $subprefecture_acronym },
                { prefetch => [ "regions" ] }
            )->next();

            LOGDIE "Não foi possível encontrar o acronimo em '$subprefecture_name'." unless ref$subprefecture;

            my $action_line_ids = $line->{'Linha de ação'};
            my ($action_line_id, $action_line_subid) = split m{\.}, $action_line_ids;

            my $action_line = $schema->resultset('ActionLine')->search(
                {
                    'me.id'    => $action_line_id,
                    'me.subid' => $action_line_subid,
                }
            )->next();

            LOGDIE "Não foi possível encontrar a linha de ação id '$action_line_ids'." unless ref $action_line;
        }
        else {
            LOGDIE "Não foi possível encontrar o acronimo em '$subprefecture_name'.";
        }

    }
});

close $fh or LOGDIE $!;

INFO "Fim da execução.";

