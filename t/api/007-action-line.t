use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

rest_get "/api/action-line", name => "get action lines", stash => "action_lines";

stash_test "action_lines" => sub {
    my $res = shift;

    is( ref $res->{action_lines}, 'ARRAY', "list of action lines" );
    is( ref $res->{action_lines}->[0], 'HASH' );

    is_deeply(
        [ sort keys %{ $res->{action_lines}->[0] } ],
        [ qw/ achievement id indicator_description title / ],
    );
};

done_testing();

