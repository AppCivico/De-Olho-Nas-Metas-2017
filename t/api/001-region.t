use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

db_transaction {
    rest_get "/api/region", name => "list regions", stash => "region";

    stash_test "region" => sub {
        my $res = shift;

        is( ref($res), "HASH", 'returns a hashref' );
        is( scalar @{ $res->{region} }, 96, 'count=96' );
    };
};

done_testing();
