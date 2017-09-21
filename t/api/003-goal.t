use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

db_transaction {
    rest_get "/api/goal", name => "list goals", stash => "goal";

    stash_test "goal" => sub {
        my $res = shift;

        is (ref $res->{goal}, "ARRAY", 'list of goals');
    };
};

done_testing();
