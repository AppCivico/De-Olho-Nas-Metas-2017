use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

db_transaction {
    rest_get "/api/topic", name => "list topics", stash => "topic";

    stash_test "topic" => sub {
        my $res = shift;

        is( ref($res), "HASH", 'returns a hashref' );
        is( scalar @{ $res->{topic} }, 5, 'count=5' );

        ok( ( grep { $_->{name} eq "Desenvolvimento Humano" } @{ $res->{topic} } ), "Desenvolvimento Humano");
        ok( ( grep { $_->{name} eq "Desenvolvimento Social" } @{ $res->{topic} } ), "Desenvolvimento Social");
        ok(
            ( grep { $_->{name} eq "Desenvolvimento Econômico E Gestão" } @{ $res->{topic} } ),
            "Desenvolvimento Econômico E Gestão"
        );
        ok(
            ( grep { $_->{name} eq "Desenvolvimento Institucional" } @{ $res->{topic} } ),
            "Desenvolvimento Institucional"
        );
        ok(
            ( grep { $_->{name} eq "Desenvolvimento Urbano E Meio Ambiente" } @{ $res->{topic} } ),
            "Desenvolvimento Urbano E Meio Ambiente"
        );
    };
};

done_testing();
