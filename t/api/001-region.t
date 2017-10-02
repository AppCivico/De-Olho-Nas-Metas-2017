use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

db_transaction {
    rest_get "/api/region", name => "list regions", stash => "regions";

    stash_test "regions" => sub {
        my $res = shift;

        is( ref($res), "HASH", 'returns a hashref' );
        is( scalar @{ $res->{regions} }, 96, 'count=96' );
    };

    rest_get "/api/region/630",
        name  => "get region",
        stash => "region";
    ;

    stash_test "region" => sub {
        my $res = shift;

        is( $res->{region}->{id}, 630, 'id=630' );
        is( $res->{region}->{name}, 'Sacomã', 'name=Sacomã' );
        is( $res->{region}->{subprefecture_id}, 11, 'subprefecture_id=11' );
        is( $res->{region}->{subprefecture}->{id}, 11, 'subprefecture_id=11' );
        is( $res->{region}->{subprefecture}->{name}, 'Ipiranga', 'subprefecture_name=Ipiranga' );
        is( ref $res->{region}->{region_variables}, 'ARRAY', 'region_variables=ARRAY' );
        is( $res->{region}->{region_variables}->[0]->{variable_id}, 19, 'variable_id=19' );

    }
};

done_testing();
