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

        is( ref $res->{goal}, "ARRAY", 'list of goals' );
        is( scalar (@{ $res->{goal} }), 53, 'count=53' );
    };

    # Filtro por eixo.
    rest_get "/api/goal",
        name => "filter by topic",
        stash => "goal_filter_topic",
        [ topic_name => "desenvolvimento humano" ],
    ;

    stash_test "goal_filter_topic" => sub {
        my $res = shift;

        is( scalar (@{ $res->{goal} }), 11, 'count=11' );
    };

    # Filtro por título.
    rest_get "/api/goal",
        name => "filter by title",
        stash => "goal_filter_title",
        [ title => "Implantar" ],
    ;

    stash_test "goal_filter_title" => sub {
        my $res = shift;

        is( scalar (@{ $res->{goal} }), 2, 'count=2' );
        is_deeply(
            [ map { $_->{id} } @{ $res->{goal} } ],
            [ 33, 41 ],
            "correct id's",
        );
    };


    # Obtendo dados de uma meta específica.
    my $goal_id = fake_pick( map { $_->{id} } @{ (stash("goals")->{goal}) } )->();

    rest_get [ qw(api goal), $goal_id ],
        name  => "get specifc goal",
        stash => "goal",
    ;

    stash_test "goal" => sub {
        my $res = shift;

        is( ref($res->{goal}), "HASH", "main node is hashref" );
        is( ref($res->{goal}->{topic}), "HASH", "retrieved topic" );
    };

    # Uma meta que não existe deve retornar 404.
    rest_get [ qw(api goal), 75 ],
        name    => "get goal that not exists",
        is_fail => 1,
        code    => 404,
    ;
};

done_testing();
