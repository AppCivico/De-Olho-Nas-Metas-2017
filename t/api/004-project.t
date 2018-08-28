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
                            name => "Desenvolvimento Econômico e Gestão",
                            slug => "desenvolvimento-economico-e-gestao",
                            description => "Foi articulado em torno da ideia de uma cidade inteligente, eficiente, que gera oportunidades e simplifica a vida das pessoas",
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
    rest_get "/api/project/11",
        name  => "get specifc project",
        stash => "project",
    ;

    stash_test "project" => sub {
        my $res = shift;

        is( ref($res->{project}), "HASH", "main node is hashref" );
        is( ref($res->{project}->{topics}), "ARRAY", "retrieved topic" );
        is( ref($res->{project}->{action_lines}), "ARRAY", "retrieved action lines" );
        is( ref($res->{project}->{goals}), "ARRAY", "retrieved goals" );
        is( ref($res->{project}->{subprefectures}), "ARRAY", "retrieved subprefectures" );

        is( $res->{project}->{id}, 11, "id=11" );
        is(
            $res->{project}->{description},
            "São Paulo será uma cidade Amiga do Idoso, obtendo o Selo Pleno do Programa São Paulo Amigo do Idoso.",
            'description',
        );
    };

    # Uma meta que não existe deve retornar 404.
    rest_get [ qw(api project), 100 ],
        name    => "project that does not exists",
        is_fail => 1,
        code    => 404,
    ;

    # Testando se os eixos não virão duplicados na resposta do endpoint.
    # O project_id=2 possui três metas do mesmo eixo.
    is_deeply(
        [
            map { $_->get_column("topic_id") }
              $schema->resultset("GoalProject")->search(
                  { 'me.project_id' => 2 },
                  {
                      'select' => [ "topic.id" ],
                      'as' => [ "topic_id" ],
                      join => [ { "goal" => "topic" } ],
                  },
              )->all()
        ],
        [ 2, 2, 2 ],
        'topic_id=2',
    );

    rest_get "/api/project/2",
        name  => "test duplicated topics",
        stash => "duplicated_topics",
    ;

    stash_test "duplicated_topics" => sub {
        my $res = shift;

        is( ref($res->{project}->{topics}), "ARRAY", 'topics=ARRAY' );
        is_deeply(
            $res->{project}->{topics},
            [
                {
                    id   => 2,
                    name => "Desenvolvimento Social",
                    slug => "desenvolvimento-social",
                }
            ],
            'retrieved one topic',
        );
    };

    subtest 'project badges' => sub {

        ok( my $project = $schema->resultset('Project')->search( {}, { rows => 1, order_by => \['RANDOM()'] } )->next );
        ok( my $badge   = $schema->resultset('Badge')->search( {}, { rows => 1, order_by => \['RANDOM()'] } )->next );

        ok(
            $schema->resultset('ProjectBadge')->create({
                project_id => $project->id,
                badge_id   => $badge->id,
            }),
            'add relationship'
        );

        rest_get [ qw/ api project /, $project->id ],
            name  => 'get project',
            stash => 'project_badge',
        ;

        stash_test 'project_badge' => sub {
            my $res = shift;

            is( ref $res->{project}->{badges},          'ARRAY',      'badges=ARRAY' );
            is( $res->{project}->{badges}->[0]->{id},   $badge->id,   'badge_id' );
            is( $res->{project}->{badges}->[0]->{name}, $badge->name, 'name' );
        };
    };

    subtest 'project additional information' => sub {

        my $project = $schema->resultset('Project')->search({}, { rows => 1, order_by => [\'RANDOM()'] })->next;
        my $description = fake_paragraphs(1)->();

        ok $project->project_additional_informations->create({
            description => $description,
            inserted_at => fake_past_datetime->(),
            hash        => 'foobar',
            updated_at  => \'NOW()',
        });

        rest_get [ qw/ api project /, $project->id ],
            name  => 'get project',
            stash => 'project_additional_information',
        ;

        stash_test 'project_additional_information' => sub {
            my $res = shift;

            is ref $res->{project}->{additional_information}, 'ARRAY', 'additional_information=ARRAY';
            is $res->{project}->{additional_information}->[0]->{description}, $description, 'description';
        };
    };

    subtest 'project budget execution' => sub {

        my $project = $schema->resultset('Project')->search({}, { rows => 1, order_by => [\'RANDOM()'] })->next;
        ok $project->project_budget_executions->create({
            year => 2018,
            (
                map { $_ => fake_words(3)->() }
                qw/ own_resources_investment own_resources_costing own_resources_total other_resources_investment
                other_resources_costing other_resources_total total_year_investment total_year_costing total_year_total /
            ),
        });

        rest_get [ qw/ api project /, $project->id ],
            name  => 'get project',
            stash => 'project_budget_execution',
        ;

        stash_test 'project_budget_execution' => sub {
            my $res = shift;

            is ref $res->{project}->{budget_executions}, 'ARRAY', 'budget_executions=ARRAY';
            is $res->{project}->{budget_executions}->[0]->{year}, 2018, 'year=2018';
        };
    };

    subtest 'project secretariat' => sub {

        my $project     = $schema->resultset('Project')->search({}, { rows => 1, order_by => [\'RANDOM()'] })->next;
        my $secretariat = $schema->resultset('Secretariat')->search({}, { rows => 1, order_by => [\'RANDOM()'] })->next;

        ok $project->project_secretariats->create({
            secretariat_id => $secretariat->id,
            updated_at     => \'NOW()',
        });

        rest_get [ qw/ api project /, $project->id ],
            name  => 'get project',
            stash => 'project_secretariat',
        ;

        stash_test 'project_secretariat' => sub {
            my $res = shift;

            is ref $res->{project}->{secretariats}, 'ARRAY', 'secretariats=ARRAY';
            is $res->{project}->{secretariats}->[0]->{id},   $secretariat->id,   'secretariat_id';
            is $res->{project}->{secretariats}->[0]->{name}, $secretariat->name, 'secretariat_name';
        };
    };
};

done_testing();
