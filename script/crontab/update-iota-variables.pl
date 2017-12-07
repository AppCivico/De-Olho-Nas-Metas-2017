#!/usr/bin/env perl
use common::sense;
use open ":locale";
use FindBin qw($RealBin $Script);
use lib "$RealBin/../../lib";

use Text::CSV;
use Tie::Handle::CSV;
use JSON::XS;
use DateTime::Format::Strptime;
use Donm::SchemaConnected;
use Log::Log4perl qw(:easy);
use LWP::UserAgent;
use DDP;

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
    19 => 'População total',

    # Assistencia social.
    512 => "Número total da população em situação de rua que foi acolhida",
    285 => "Número total de indivíduos em situação de rua",

    # Cultura.
    250 => "Número de livros infanto-juvenis disponíveis em acervos de bibliotecas",
    71  => "Número total de livros para adultos disponíveis em bibliotecas municipais",
    249 => "Número de centros culturais, espaços e casas de cultura",
    572 => "Número total de salas de cinema",
    555 => "Ńúmero total de museus",
    573 => "Número total de salas de show e concerto",
    575 => "Número total de salas de teatro",

    # Educação.
    77  => "Número de matrículas efetuadas em creches municipais",
    78  => "Número total de inscritos em creches (matrículas efetuadas + vagas solicitadas)",
    269 => "Número total de matrículas  em pré-escolas municipais",
    270 => "Número total de inscritos em pré-escolas municipais (matrículas efetuadas + vagas solicitadas)",

    # Esporte.
    60  => "Número total de equipamentos esportivos públicos",
    577 => "Número total de unidades esportivas públicas",

    # Habitação.
    545 => "Número total de domicílios em favelas",
    92  => "Número total de indivíduos residentes em favelas",

    # Inclusão digital.
    576 => "Número total de telecentros",

    # Meio ambiente.
    61 => "Número total, em m², de áreas verdes",

    # Saúde.
    231 => "Número total de crianças com baixo peso ao nascer",
    58 => "Número total de leitos hospitalares",
    3767 => "Número de óbitos de residentes por aids",
    230 => "Número total de óbitos por causas maternas",
    557 => "Número total de óbitos por causas externas",
    558 => "Número total de óbitos por causas mal definidas",
    227 => "Número total de óbitos por doenças do aparelho circulatório",
    226 => "Número total de óbitos por doenças do aparelho respiratório",
    508 => "Número de óbitos por neoplasias",
    3937 => "Idade média ao morrer",
    57 => "Número total de unidades básicas de atendimento em saúde",

    # Trabalho e renda.
    548 => "Número total de empregos",
    72 => "Taxa média de desemprego",

    # Transporte/Acidentes de trânsito
    294 => "Total de mortes de ocupantes de automóveis e caminhonetes",
    293 => "Total de mortes de ocupantes de motocicleta",
    214 => "Total de mortes com bicicleta",
    296 => "Número total de atropelamentos",
    91 => "Número de mortes em acidentes de trânsito",

    # Violência.
    277 => "Número total de internações de crianças residentes, de até 14 anos por causas relacionadas a possíveis agressões",
    279 => "Número total de internações de pessoas residentes, de 60 anos ou mais, por causas relacionadas a possível agressão",
    280 => "Número total de internações de mulheres residentes, de 20 a 59 anos, por causas relacionadas a possíveis agressões",
    81 => "Número total de mortes por homicídio de jovens homens com idade de 15 a 29 anos",
    82 => "Número total de óbitos por homicídio",
    83 => "Número total de roubos",
);

for my $variable_id (keys %variables) {
    DEBUG "Verificando se a variável id '$variable_id' já está cadastrada no sistema.";

    my $variable_name = $variables{$variable_id};

    $schema->resultset("Variable")->find_or_create(
        {
            id   => $variable_id,
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

                my $dt = $strp->parse_datetime($most_recent_data->{valid_from});

                my $region = $schema->resultset("Region")->search( { name => { 'ilike' => $region_name } } )->next;
                if (ref $region) {
                    my $region_variable_rs = $schema->resultset('RegionVariable');

                    my $region_variable = $region_variable_rs->search(
                        {
                            region_id   => $region->id,
                            variable_id => $variable_id,
                        }
                    )->next;

                    my $source = $most_recent_data->{source};

                    if (ref $region_variable) {
                        $region_variable->update(
                            {
                                value  => $value,
                                year   => $dt->year,
                                source => $source,
                            }
                        );
                    }
                    else {
                        $region_variable_rs->create(
                            {
                                region_id   => $region->id,
                                variable_id => $variable_id,
                                value       => $value,
                                year        => $dt->year,
                                source      => $source,
                            }
                        );
                    }
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

