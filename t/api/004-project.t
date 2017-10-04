use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

db_transaction {
    # Listagem.
    rest_get "/api/project", name => "list projects", stash => "projects";

    stash_test "projects" => sub {
        my $res = shift;

        is( ref $res->{projects}, "ARRAY", 'array of projects');
        is( scalar @{ $res->{projects} }, 71, 'count=71');
    };

    # Filtro por título.
    rest_get "/api/project",
        name  => "filter by title",
        stash => "project_filter_title",
        [ title => "desestatização" ],
    ;

    stash_test "project_filter_title" => sub {
        my $res = shift;

        is( scalar (@{ $res->{projects} }), 1, 'count=1' );

        is_deeply(
            $res->{projects},
            [
                {
                    id     => 59,
                    title  => "Plano Municipal de Desestatização",
                    slug   => "plano-municipal-de-desestatizacao",
                    description =>
"Plano Municipal de Desestatização: contempla o arcabouço legal e institucional necessário para a viabilização dos projetos de desestatização e parcerias",
                    topics => [
                        {
                            id   => 5,
                            name => "Desenvolvimento Econômico E Gestão",
                            slug => "desenvolvimento-economico-e-gestao",
                        }
                    ],
                },
            ],
            'only one result',
        );
    };

    # Filtro por eixo.
    rest_get "/api/project",
        name  => "filter by topic",
        stash => "project_filter_topic",
        [ topic_name => "desenvolvimento institucional" ],
    ;

    stash_test "project_filter_topic" => sub {
        my $res = shift;

        for my $project ( @{ $res->{projects} } ) {
            my $ok = 0;

            for my $topic ( @{ $project->{topics } } ) {
                $ok = 1 if $topic->{name} eq "Desenvolvimento Institucional";
            }

            ok( $ok, 'there are at least one topic like as looked for' );
        }
    };

    # Obtendo dados de um projeto específico.
    rest_get "/api/project/10",
        name  => "get specifc project",
        stash => "project",
    ;

    stash_test "project" => sub {
        my $res = shift;

        is( ref($res->{project}), "HASH", "main node is hashref" );
        is( ref($res->{project}->{topics}), "ARRAY", "retrieved topic" );
        is( ref($res->{project}->{action_lines}), "ARRAY", "retrieved action lines" );
        is( ref($res->{project}->{goals}), "ARRAY", "retrieved goals" );

        is( $res->{project}->{id}, 10, "id=10" );
        is(
            $res->{project}->{description},
            "Implementar balcões de cidadania (pontos de Direitos Humanos) em toda a cidade.",
            'description',
        );
    };

    # Uma meta que não existe deve retornar 404.
    rest_get [ qw(api project), 100 ],
        name    => "get project that not exists",
        is_fail => 1,
        code    => 404,
    ;
};

done_testing();
