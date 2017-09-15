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

my $fh = Tie::Handle::CSV->new("$RealBin/../../dataset/database.csv", header => 1);

while (my $line = <$fh>) {
    # Adicionando projeto.
    $line = { %{ $line } };

    $schema->resultset("Project")->find_or_create(
        {
            id    => delete $line->{'ID Projeto'},
            title => delete $line->{'Título do Projeto'},
        },
        { key => "primary" }
    );

    # Adicionando meta.
    $schema->resultset("Goal")->find_or_create(
        {
            id    => delete $line->{'ID Meta'},
            title => delete $line->{'Título da Meta'},
        },
        { key => "primary" }
    );

    my $action_line_ids = delete $line->{'ID Linha de Ação'};
    my @action_line_ids = split m{\.}, $action_line_ids;

    $schema->resultset("ActionLine")->find_or_create(
        {
            id    => $action_line_ids[0],
            subid => $action_line_ids[1],
            title => delete $line->{'Título da Linha de Ação'},
        },
        { key => "primary" }
    );

    p $line;
}

close $fh or LOGDIE $!;

INFO "Fim da execução.";

