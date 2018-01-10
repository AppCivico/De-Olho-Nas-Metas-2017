use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

rest_get "/api/indicator", name => "get indicators", stash => "indicators";

stash_test 'indicators' => sub {
    my $res = shift;

    is( ref($res->{indicators}), 'ARRAY', 'indicators list' );
    is_deeply(
        [ sort keys %{ $res->{indicators}->[0] } ],
        [ sort qw/ id name regions explanation formula / ],
    );

    is( ref($res->{indicators}->[0]->{regions}), 'ARRAY', 'list of regions' );
    is_deeply(
        [ sort keys %{ $res->{indicators}->[0]->{regions}->[0] } ],
        [ sort qw/ id name value sources year url_observatorio / ],
    );
};

done_testing();

