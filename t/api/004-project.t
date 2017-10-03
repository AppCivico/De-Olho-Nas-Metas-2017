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
};

done_testing();
