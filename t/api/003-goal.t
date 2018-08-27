use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

db_transaction {
    # Listagem.
    rest_get "/api/goal", name => "list goals", stash => "goals";

    stash_test "goals" => sub {
        my $res = shift;

        is( ref $res->{goals}, "ARRAY", 'list of goals' );
        is( scalar (@{ $res->{goals} }), 53, 'count=53' );
    };

    # Filtro por eixo.
    rest_get "/api/goal",
        name => "filter by topic",
        stash => "goal_filter_topic",
        [ topic_name => "desenvolvimento humano" ],
    ;

    stash_test "goal_filter_topic" => sub {
        my $res = shift;

        is( scalar (@{ $res->{goals} }), 11, 'count=11' );
    };

    # Filtro por título.
    rest_get "/api/goal",
        name => "filter by title",
        stash => "goal_filter_title",
        [ title => "Implantar" ],
    ;

    stash_test "goal_filter_title" => sub {
        my $res = shift;

        is( scalar (@{ $res->{goals} }), 2, 'count=2' );
        is_deeply(
            [ map { $_->{id} } @{ $res->{goals} } ],
            [ 33, 41 ],
            "correct id's",
        );
    };

    # Obtendo dados de uma meta específica.
    rest_get [ qw/ api goal 1 / ],
        name  => "get specifc goal",
        stash => "goal",
    ;

    stash_test "goal" => sub {
        my $res = shift;

        is( ref($res->{goal}), "HASH", 'main node is hashref' );
        is( ref($res->{goal}->{topics}), 'ARRAY', 'retrieved topic' );
        is( ref($res->{goal}->{projects}), "ARRAY", 'retrieved projects' );
        is( ref($res->{goal}->{subprefectures}), "ARRAY", 'retrieved subprefectures' );

        is( $res->{goal}->{id}, 1, 'id=1' );
        like( $res->{goal}->{title}, qr/^Aumentar a cobertura/, 'title' );
        is(
            $res->{goal}->{indicator_description},
            "Indicador de cobertura populacional estimada da atenção básica.",
            'indicator_description',
        );
    };

    # Uma meta que não existe deve retornar 404.
    rest_get [ qw(api goal), 75 ],
        name    => "get goal that not exists",
        is_fail => 1,
        code    => 404,
    ;

    subtest 'goal badge' => sub {

        ok( my $goal  = $schema->resultset('Goal')->search( { 'me.id' => 1 } )->next  );
        ok( my $badge = $schema->resultset('Badge')->search( { 'me.id' => 1 } )->next );

        ok(
            $schema->resultset('GoalBadge')->create({
                goal_id  => $goal->id,
                badge_id => $badge->id
            }),
            'add relationship'
        );

        rest_get [ qw/ api goal /, $goal->id ],
            name  => 'get goal',
            stash => 'goal_badge',
        ;

        stash_test 'goal_badge' => sub {
            my $res = shift;

            is( ref $res->{goal}->{badges},          'ARRAY', 'badges=ARRAY' );
            is( $res->{goal}->{badges}->[0]->{id},   '1',     'badge_id=1' );
            is( $res->{goal}->{badges}->[0]->{name}, 'Erradicação da pobreza', 'name' );
        };
    };

    subtest 'goal execution' => sub {

        my $goal_id = 4;
        my $goal_execution_rs = $schema->resultset('GoalExecution')->search( { 'me.goal_id' => $goal_id } );

        ok( $goal_execution_rs->delete(), 'delete goal execution' );
        ok(
            $schema->resultset('GoalExecution')
            ->create(
                {
                    goal_id     => $goal_id,
                    period      => 5,
                    value       => 10,
                    accumulated => 'false',
                }
            ),
            'add goal execution',
        );

        rest_get [ qw/ api goal /, $goal_id ],
            name  => 'get goal id=4',
            stash => 'goal_execution',
        ;

        stash_test 'goal_execution' => sub {
            my $res = shift;

            is( $res->{goal}->{execution}->[0]->{semester}, 1,    'semester=1' );
            is( $res->{goal}->{execution}->[0]->{year},     2020, 'year=2020'  );
        };
    };

    subtest 'goal execution by subprefecture' => sub {

        my $goal = $schema->resultset('Goal')->search({}, { rows => 1, order_by => [\'RANDOM()'] })->next;
        my $subprefecture = $schema->resultset('Subprefecture')->search({}, { rows => 1, order_by => [\'RANDOM()'] })->next;

        ok $schema->resultset('GoalExecutionSubprefecture')->create({
            goal_id          => $goal->id,
            subprefecture_id => $subprefecture->id,
            period           => 2,
            value            => fake_int(1, 10000)->(),
            updated_at       => \'NOW()',
        });

        ok $schema->resultset('GoalExecutionSubprefecture')->create({
            goal_id          => $goal->id,
            subprefecture_id => $subprefecture->id,
            period           => 9,
            value            => fake_int(1, 10000)->(),
            updated_at       => \'NOW()',
        });

        rest_get [ qw/ api goal /, $goal->id ],
            name  => 'get goal',
            stash => 'goal_execution_subprefecture',
        ;

        stash_test 'goal_execution_subprefecture' => sub {
            my $res = shift;

            is ref $res->{goal}->{execution_subprefecture}, 'ARRAY', 'execution_subprefecture=ARRAY';
            is ref $res->{goal}->{execution_subprefecture}->[0]->{subprefecture}, 'HASH', 'subprefecture=HASH';
            is scalar @{ $res->{goal}->{execution_subprefecture} }, 1, 'one item';
            is $res->{goal}->{execution_subprefecture}->[0]->{year}, '2017', 'year=2017';
            is $res->{goal}->{execution_subprefecture}->[1], undef, 'accumulated=undef';
        };
    };

    subtest 'goal additional information' => sub {

        my $goal = $schema->resultset('Goal')->search({}, { rows => 1, order_by => [\'RANDOM()'] })->next;
        my $description = fake_paragraphs(1)->();

        ok $goal->goal_additional_informations->create({
            description => $description,
            inserted_at => fake_past_datetime->(),
            updated_at  => \'NOW()',
        });

        rest_get [ qw/ api goal /, $goal->id ],
            name  => 'get goal',
            stash => 'goal_additional_information',
        ;

        stash_test 'goal_additional_information' => sub {
            my $res = shift;

            is ref $res->{goal}->{additional_information}, 'ARRAY', 'additional_information=ARRAY';
            is $res->{goal}->{additional_information}->[0]->{description}, $description, 'description';
        };
    };
};

done_testing();