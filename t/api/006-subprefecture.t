use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

rest_get "/api/subprefecture", name => "get subprefectures", stash => "subprefectures";

stash_test "subprefectures" => sub {
    my $res = shift;

    is( ref $res->{subprefectures}, 'ARRAY', 'list of subprefectures' );

    is_deeply(
        [ sort keys %{ $res->{subprefectures}->[0] } ],
        [ sort qw/ id name slug regions address email site telephone geo_json action_lines_count / ],
    );
};

rest_get "/api/subprefecture/11", name => "get subprefectures", stash => "subprefecture";

stash_test "subprefecture" => sub {
    my $res = shift;

    is( ref $res->{subprefecture}, 'HASH', 'retrieve one subprefecture' );

    is( $res->{subprefecture}->{name}, 'Ipiranga', 'name=Ipiranga' );
    is( $res->{subprefecture}->{acronym}, 'IP', 'acronym=IP' );
    is( $res->{subprefecture}->{action_lines_count}, 78, 'action_lines_count=78' );

    is_deeply(
        [ sort map { $_->{id} } @{ $res->{subprefecture}->{regions} } ],
        [ 622, 630, 664 ],
        'regions'
    );

    is_deeply(
        [ sort keys %{ $res->{subprefecture} } ],
        [ sort qw/ id name acronym address email site slug telephone regions action_lines_count action_lines deputy_mayor / ],
    );
};

done_testing();
