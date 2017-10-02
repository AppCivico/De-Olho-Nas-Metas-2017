#!/usr/bin/env perl
use common::sense;
use open ":locale";
use FindBin qw($RealBin $Script);
use lib "$RealBin/../../lib";

use DDP;
use Text::CSV;
use Tie::Handle::CSV;
use JSON::XS;
use DateTime::Format::Strptime;
use Donm::SchemaConnected;
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

my $schema = get_schema();

# Variaveis desejadas.
my %variables = (
    27 => 'Área total do município em quilômetros quadrados (km²)',
    #19 => 'População total',

    # TODO Verificar se a cidade de São Paulo possui estas variáveis abaixo.
    #2260 => 'Renda per capita',
    #1839 => 'População (IBGE)',
    #3037 => 'Renda per capita média mensal',
    #1802 => 'Densidade demográfica do município',
    #3192 => 'IDH',
);

for my $variable_id (keys %variables) {
    DEBUG "Verificando se a variável id '$variable_id' já está cadastrada no sistema.";

    my $variable_name = $variables{$variable_id};

    $schema->resultset("Variable")->find_or_create(
        {
            id => $variable_id,
            name => $variable_name,
        },
        { key => "primary" },
    );
}

# Carregando lista de regiões.
my %regions = ();

my $fh = Tie::Handle::CSV->new("$RealBin/../../dataset/iota-regions.csv", header => 1);

while (my $line = <$fh>) {
    next if $line->{depth_level} != 3;

    my $region_id = $line->{id};
    my $region_name = $line->{name};

    $regions{$region_id} = $region_name;
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
            my $json = decode_json $res->decoded_content;
            my $data = $json->{data};

            # A API do Iota traz a informação referente a diversos anos. Para buscar o valor mais novo, farei um sort
            # a partir do campo 'valid_from' a fim de encontrar o node com a informação mais recente.
            my $strp = DateTime::Format::Strptime->new(
                pattern   => '%d/%m/%Y',
                on_error  => 'croak',
            );

            my @data = sort {
                $strp->parse_datetime($a->{valid_from}) <=> $strp->parse_datetime($b->{valid_from})
            } @{ $data };

            if (@data) {
                my $most_recent_data = pop @data;
                my $value = $most_recent_data->{value};

                my $region = $schema->resultset("Region")->search( { name => { 'ilike', $region_name } } )->next;
                if (ref $region) {
                    $schema->resultset("RegionVariable")->create(
                        {
                            region_id   => $region->id,
                            variable_id => $variable_id,
                            value       => $value,
                        }
                    );
                }
                else {
                    LOGDIE "A região id '$region_id' não existe no Donm.";
                }
            }
            else {
                INFO "Não há dados para a região '$region_name' e variável '$variable_name'.";
            }
        }
        else {
            LOGDIE "Erro na requisição: " . $res->status_line;
        }
    }

    INFO "Todas as variáveis do distrito '$region_name' foram capturadas.";
}

INFO "Fim da execução.";

