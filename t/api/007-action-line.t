use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

db_transaction {
    rest_get "/api/action-line", name => "get action lines", stash => "action_lines";

    stash_test "action_lines" => sub {
        my $res = shift;

        is( ref $res->{action_lines}, 'ARRAY', "list of action lines" );
        is( ref $res->{action_lines}->[0], 'HASH' );

        is_deeply(
            [ sort keys %{ $res->{action_lines}->[0] } ],
            [ sort qw/ achievement id indicator_description title slug / ],
        );
    };

    rest_get "/api/action-line/57.3", name => "get ation line", stash => "action_line";

    stash_test "action_line" => sub {
        my $res = shift;

        is( ref $res->{action_line}, 'HASH', 'retrieve one action line' );

        is( $res->{action_line}->{id},                    "57.3", 'id=57.3' );
        is( $res->{action_line}->{achievement},           undef, 'achievement' );
        is( $res->{action_line}->{title},                 "Implantar 120 novos pontos de WiFi.", 'title' );
        is( $res->{action_line}->{indicator_description}, "Soma dos novos pontos de WiFi implantados", 'title' );

        is_deeply(
            $res->{action_line}->{project},
            {
                id    => 57,
                title => 'WiFi SP',
                slug  => 'wifi-sp',
                description => 'Implantação do programa WiFi SP.',
            },
            'project',
        );

        is_deeply(
            [ sort keys %{ $res->{action_line} } ],
            [ sort qw/ id achievement title indicator_description subprefectures project slug executions execution_subprefectures status indicator last_updated_at / ],
        );
    };

    subtest 'action line execution' => sub {

        my $action_line = $schema->resultset('ActionLine')->search({}, { rows => 1, order_by => [\'RANDOM()'] })->next;
        ok $action_line->action_line_executions->create({
            value       => fake_words(3)->(),
            period      => 4,
            accumulated => 'true',
        });

        my $subprefecture = $schema->resultset('Subprefecture')->search({}, { rows => 1, order_by => [\'RANDOM()'] })->next;
        my $subprefecture_id = $subprefecture->id;

        ok $action_line->action_line_execution_subprefectures->create({
            subprefecture_id => $subprefecture_id,
            value            => fake_words(3)->(),
            period           => 2,
        });

        rest_get ['/api/action-line', $action_line->get_exhibition_id() ],
          name  => 'get action line execution',
          stash => 'action_line_execution'
        ;

        stash_test 'action_line_execution' => sub {
            my $res = shift;

            is ref $res->{action_line}->{executions},              'ARRAY', 'executions=ARRAY';
            is $res->{action_line}->{executions}->[0]->{year},     2018,    'year=2018';
            is $res->{action_line}->{executions}->[0]->{semester}, 2,       'semester=2';

            is ref $res->{action_line}->{execution_subprefectures},             'HASH', 'execution_subprefectures=HASH';
            is $res->{action_line}->{execution_subprefectures}->{$subprefecture_id}->{per_semester}->[0]->{year},     2017,   'year=2017';
            is $res->{action_line}->{execution_subprefectures}->{$subprefecture_id}->{per_semester}->[0]->{semester}, 2,      'semester=2';
        };
    };
};

done_testing();

