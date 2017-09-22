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
                    id => 59,
                    title => "Plano Municipal de Desestatização",
                    topics => [
                        {
                            id   => 5,
                            name => "Desenvolvimento Econômico E Gestão",
                        }
                    ],
                },
            ],
            'only one result',
        );
    };
};

done_testing();
