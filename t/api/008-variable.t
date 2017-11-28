use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

rest_get "/api/variable", name => "get variables", stash => "variables";

stash_test 'variables' => sub {
    my $res = shift;

    is( ref($res->{variables}), 'ARRAY', 'variables list' );
    is_deeply(
        [ sort keys %{ $res->{variables}->[0] } ],
        [ sort qw/ id name regions / ],
    );

    is( ref($res->{variables}->[0]->{regions}), 'ARRAY', 'list of regions' );
    is_deeply(
        [ sort keys %{ $res->{variables}->[0]->{regions}->[0] } ],
        [ sort qw/ id name value / ],
    );
};

done_testing();

