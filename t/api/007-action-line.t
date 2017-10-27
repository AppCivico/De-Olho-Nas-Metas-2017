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

rest_get "/api/action-line/60.9", name => "get ation line", stash => "action_line";

stash_test "action_line" => sub {
    my $res = shift;

    is( ref $res->{action_line}, 'HASH', 'retrieve one action line' );

    is( $res->{action_line}->{id}, "60.9", 'id=60.9' );
    is( $res->{action_line}->{achievement}, "Marca licenciada", 'achievement' );
    is( $res->{action_line}->{title}, "Licenciar o uso da marca.", 'title' );

    is_deeply(
        [ sort keys %{ $res->{action_line} } ],
        [ sort qw/ id achievement title indicator_description subprefectures slug / ],
    );
};

done_testing();

