use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

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
        [ sort qw/ id achievement title indicator_description subprefectures project slug / ],
    );
};

done_testing();

