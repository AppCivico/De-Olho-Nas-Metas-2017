use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

db_transaction {
    rest_get "/api/subprefecture", name => "get subprefectures", stash => "subprefecture";

    stash_test "subprefecture" => sub {
        my $res = shift;

        p $res;
    };
};

done_testing();
