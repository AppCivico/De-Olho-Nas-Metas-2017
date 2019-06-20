use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

db_transaction {
    rest_get "/api/badges", name => "list badges", stash => "badges";

    stash_test "badges" => sub {
        my $res = shift;

        is( ref $res->{badges}, 'ARRAY', 'badges=array' );
        is( $res->{badges}->[0]->{id}, 1, 'id=1');
        is( $res->{badges}->[0]->{name}, 'Erradicação da pobreza', 'name=Erradicação da pobreza');
    };
};

done_testing();
