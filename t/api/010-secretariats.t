use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

db_transaction {
    rest_get "/api/secretariats", name => "list secretariats", stash => "secretariats";

    stash_test "secretariats" => sub {
        my $res = shift;

        is( ref $res->{secretariats}, 'ARRAY', 'secretariats=array' );
        is( scalar(grep { m{^Secretaria} }  map { $_->{name} } @{ $res->{secretariats} }), '22' );
        is( scalar(grep { !m{^Secretaria} } map { $_->{name} } @{ $res->{secretariats} }), '1' );
    };
};

done_testing();
