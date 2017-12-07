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
        is( $res->{region}->{slug}, 'sacoma', 'slug=sacoma' );
        is( $res->{region}->{subprefecture_id}, 11, 'subprefecture_id=11' );
        is( $res->{region}->{subprefecture}->{id}, 11, 'subprefecture_id=11' );
        is( $res->{region}->{subprefecture}->{name}, 'Ipiranga', 'subprefecture_name=Ipiranga' );
        is( ref $res->{region}->{variables}, 'ARRAY', 'region_variables=ARRAY' );
        is( $res->{region}->{variables}->[0]->{id}, 230, 'variable_id=230' );
    }
};

done_testing();
