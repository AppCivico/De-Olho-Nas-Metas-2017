use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

db_transaction {
    rest_get "/api/goal", name => "list goals", stash => "goal";

    stash_test "goal" => sub {
        my $res = shift;

        p $res;
    };
};

done_testing();
