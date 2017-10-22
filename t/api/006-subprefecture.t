use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

rest_get "/api/subprefecture", name => "get subprefectures", stash => "subprefectures";

stash_test "subprefectures" => sub {
    my $res = shift;

    is( ref $res->{subprefectures}, 'ARRAY', 'list of subprefectures' );
};

rest_get "/api/subprefecture/11", name => "get subprefectures", stash => "subprefecture";

stash_test "subprefecture" => sub {
    my $res = shift;

    is( ref $res->{subprefecture}, 'HASH', 'retrieve one subprefecture' );

    is_deeply(
        [ sort keys %{ $res->{subprefecture} } ],
        [ sort qw/ id name acronym address email site slug telephone regions / ],
    );
};

done_testing();
