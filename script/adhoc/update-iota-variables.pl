#!/usr/bin/env perl
use common::sense;
use open ":locale";
use FindBin qw($RealBin $Script);
use lib "$RealBin/../../lib";

use DDP;
use Text::CSV;
use Tie::Handle::CSV;
use Log::Log4perl qw(:easy);
use LWP::UserAgent;

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

# Variaveis desejadas.
my %variables = (
    27 => 'Área total do município em quilômetros quadrados (km²)',
    19 => 'População total',

    # TODO Verificar se a cidade de São Paulo possui estas variáveis abaixo.
    #2260 => 'Renda per capita',
    #1839 => 'População (IBGE)',
    #3037 => 'Renda per capita média mensal',
    #1802 => 'Densidade demográfica do município',
    #3192 => 'IDH',
);

# Carregando lista de regiões.
my %regions = ();

my $fh = Tie::Handle::CSV->new("$RealBin/../../dataset/iota-regions.csv", header => 1);

while (my $line = <$fh>) {
    next if $line->{depth_level} != 3;

    my $id = $line->{id};
    $regions{$id} = $line->{name};
}

close $fh or LOGDIE $!;

# Endpoint do Iota.
my $endpoint = "http://www.redesocialdecidades.org.br";
my $ua = LWP::UserAgent->new();
$ua->env_proxy();
$ua->default_header( 'User-Agent' => "AppCivico/1.0" );

# Atualizando regiões.
# http://www.redesocialdecidades.org.br/download-variables?city_id=1&region_id=288&variable_id=1839
for my $region_id (keys %regions) {
    my $region_name = $regions{$region_id};

    INFO "Buscando dados do distrito '$region_name'.";

    for my $variable_id (keys %variables) {
        my $variable_name = $variables{$variable_id};

        DEBUG "Obtendo a variavel '$variable_name' do distrito '$region_name'.";

        my $res = $ua->get(
            $endpoint . "/download-variables?city_id=1&region_id=" . $region_id . "&variable_id=" . $variable_id
        );

        if ($res->is_success()) {
            p $res->decoded_content;
        }
        else {
            LOGDIE "Erro na requisição: " . $res->status_line;
        }
    }

    INFO "Todas as variáveis do distrito '$region_name' foram capturadas.";
}

INFO "Fim da execução.";

