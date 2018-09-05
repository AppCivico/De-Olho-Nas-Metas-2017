use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

db_transaction {
    subtest 'download goals' => sub {

        my $req = request('/download/goals');
        ok $req->is_success, 'ok';
        p $req;
    };
};

done_testing();

