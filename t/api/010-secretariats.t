use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

db_transaction {
    subtest 'load data' => sub {

        my $goal_rs = $schema->resultset('Goal')->search(undef, { rows => 5 });
        while (my $goal = $goal_rs->next()) {
            $goal->update({
                secretariat => fake_pick(
                    "Secretaria do Governo Municipal",
                    "Secretaria Municipal de Mobilidade e Transportes",
                    "Secretaria Municipal de Cultura",
                    "Secretaria Municipal da Fazenda",
                    "Secretaria Municipal de Habitação",
                    "Secretaria Municipal de Educação",
                    "Secretaria Municipal da Saúde",
                )->(),
            });
        }
        ok( 1, 'update goals' );
    };

    rest_get "/api/secretariats", name => "list secretariats", stash => "secretariats";

    stash_test "secretariats" => sub {
        my $res = shift;

        is( ref $res->{secretariats}, 'ARRAY', 'secretariats=array' );
        is( scalar(grep { m{^(?!Secretaria)} } @{ $res->{secretariats} }), '0' );
    };
};

done_testing();
