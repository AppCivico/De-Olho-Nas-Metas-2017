#!/usr/bin/env perl
use common::sense;
use open ":locale";
use FindBin qw($RealBin $Script);
use lib "$RealBin/../../lib";

use Text::CSV;
use Text2URI;
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
},
{
    file   => ">>$RealBin/../../log/$Script.log",
    layout => '[%d] %m%n',
    level  => $DEBUG,
    utf8   => 1,
});


INFO "Iniciando $Script...";

my $schema = get_schema();

# Indicadores desejadas.
my %indicators = (
    # Assistência social.
    282  => "População em situação de rua - acolhidos",
    184  => "População em situação de rua",

    # Cultura.
    132  => "Acervo de livros infanto-juvenis",
    22   => " Acervo de livros para adultos",
    131  => "Centros culturais, casas e espaços de cultura",
    247  => "Cinemas",
    270  => "Museus",
    296  => "Salas de show e concerto",
    299  => "Teatros",

    # Educação.
    241  => "Atendimento nas creches municipais",
    242  => "Atendimento nas pré-escolas municipais",
    98   => "Demanda atendida em creches",
    147  => "Demanda atendida de vagas em pré-escolas municipais",

    # Esporte.
    7    => "Equipamentos esportivos",

    # Habitação.
    261  => "Favelas",

    # Inclusão digital.
    300  => "Telecentros",

    # Meio ambiente.
    8    => "Área verde por habitante",

    # Saúde.
    116  => "Baixo peso ao nascer",
    114  => "Gravidez na adolescência",
    5    => "Leitos hospitalares",
    3718 => "Mortalidade específica por aids",
    6    => "Mortalidade infantil",
    115  => "Mortalidade materna",
    267  => "Mortalidade por causas externas",
    268  => "Mortalidade por causas mal definidas",
    111  => "Mortalidade por doenças do aparelho respiratório",
    112  => "Mortalidade por doenças do aparelho circulatório",
    269  => "Mortalidade por neoplasias (câncer)",
    113  => "Pré-natal insuficiente",
    3856 => "Idade média ao morrer",
    4    => "Unidades Básicas de Saúde",

    # Trabalho e renda.
    258  => "Empregos",

    # Transporte/acidentes de trânsito.
    169  => "Mortes com automóvel",
    166  => "Mortes com bicicleta",
    168  => "Mortes com motocicleta",
    167  => "Mortes por atropelamento",
    76   => "Mortes no trânsito",

    # Violência.
    151  => "Agressão a crianças e adolescente",
    152  => "Agressão a idoso",
    153  => "Agressão a mulheres",
    156  => "Homicídio juvenil",
    158  => "Homicídios",
);

# Carregando lista de regiões.
my %regions = ();

my $fh = Tie::Handle::CSV->new("$RealBin/../../dataset/iota-regions.csv", header => 1);

while (my $line = <$fh>) {
    next if $line->{depth_level} != 3;

    my $region_id = $line->{id};

    $regions{$region_id} = {
        name     => $line->{name},
        name_url => $line->{name_url},
    };
}

close $fh or LOGDIE $!;

# Endpoint do Iota.
my $endpoint = "http://www.redesocialdecidades.org.br";
my $ua = LWP::UserAgent->new();
$ua->env_proxy();
$ua->default_header( 'User-Agent' => "AppCivico/1.0" );

# Atualizando regiões.
for my $region_id (keys %regions) {
    my $region_name = $regions{$region_id}->{name};

    INFO "Buscando dados do distrito '$region_name'.";

    for my $indicator_id (keys %indicators) {
        my $indicator_name = $indicators{$indicator_id};

        DEBUG "Obtendo a variavel '$indicator_name' do distrito '$region_name'.";

        my $res = $ua->get(
            $endpoint . "/download-indicators?city_id=1&region_id=" . $region_id . "&indicator_id=" . $indicator_id
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

            my @data = sort { $strp->parse_datetime($a->{valid_from}) <=> $strp->parse_datetime($b->{valid_from}) } @{ $data };

            if (@data) {
                my $most_recent_data = pop @data;
                my $value = $most_recent_data->{value};

                my $dt = $strp->parse_datetime($most_recent_data->{valid_from});

                my $region = $schema->resultset('Region')->search( { name => { 'ilike' => $region_name } } )->next;
                LOGDIE "A região id '$region_id' não existe no Donm." unless ref $region;

                my $indicator = $schema->resultset('Indicator')->search( { 'me.id' => $indicator_id } )->next;
                if (!ref $indicator) {
                    DEBUG "O indicador '$indicator_id' não existia no sistema e será criado.";
                    $indicator = $schema->resultset('Indicator')->create(
                        {
                            id          => $indicator_id,
                            name        => $most_recent_data->{indicator_name},
                            explanation => $most_recent_data->{explanation},
                            formula     => $most_recent_data->{formula_human},
                        },
                    );
                }

                my $region_indicator_rs = $schema->resultset('RegionIndicator');

                my $region_indicator = $region_indicator_rs->search(
                    {
                        'me.region_id'    => $region->id,
                        'me.indicator_id' => $indicator_id,
                    }
                )->next;

                my $sources = $most_recent_data->{sources};

                my $region_name_url = $regions{$region_id}->{name_url};
                my $text2uri = new Text2URI();
                my $indicator_name_url = $text2uri->translate($indicator_name);

                my $url_observatorio = "http://www.redesocialdecidades.org.br/br/SP/sao-paulo/regiao/$region_name_url/$indicator_name_url";

                if (ref $region_indicator) {
                    $region_indicator->update(
                        {
                            value            => $value,
                            year             => $dt->year,
                            sources          => $sources,
                            url_observatorio => $url_observatorio,
                        }
                    );
                }
                else {
                    $region_indicator_rs->create(
                        {
                            region_id    => $region->id,
                            indicator_id => $indicator_id,
                            value        => $value,
                            year         => $dt->year,
                            sources      => $sources,
                        }
                    );
                }
            }
            else {
                INFO "Não há dados para a região '$region_name' e variável '$indicator_name'.";
            }
        }
        else {
            LOGDIE "Erro na requisição: " . $res->status_line;
        }
    }

    INFO "Todas as variáveis do distrito '$region_name' foram capturadas.";
}

INFO "Fim da execução.";

