use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

db_transaction {
    rest_get "/api/sao-paulo", name => "get city", stash => "sao_paulo";

    stash_test "sao_paulo" => sub {
        my $res = shift;

        is( ref($res->{cities}), 'ARRAY', 'main entity=ARRAY' );
        ok( defined($res->{cities}->[0]->{sao_paulo}->{geo_json}), 'retrieve geojson' );
    };
};

done_testing();
