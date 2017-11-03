use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

my $schema = Donm->model("DB");

db_transaction {
    rest_get "/api/topic", name => "list topics", stash => "topics";

    stash_test "topics" => sub {
        my $res = shift;

        is( ref($res), "HASH", 'returns a hashref' );
        is( scalar @{ $res->{topics} }, 5, 'count=5' );
        is( ref($res->{topics}), "ARRAY", 'topics=arrayref' );

        ok( ( grep { $_->{name} eq "Desenvolvimento Humano" } @{ $res->{topics} } ), "Desenvolvimento Humano");
        ok( ( grep { $_->{name} eq "Desenvolvimento Social" } @{ $res->{topics} } ), "Desenvolvimento Social");
        ok(
            ( grep { $_->{name} eq "Desenvolvimento Econômico E Gestão" } @{ $res->{topics} } ),
            "Desenvolvimento Econômico E Gestão"
        );
        ok(
            ( grep { $_->{name} eq "Desenvolvimento Institucional" } @{ $res->{topics} } ),
            "Desenvolvimento Institucional"
        );
        ok(
            ( grep { $_->{name} eq "Desenvolvimento Urbano E Meio Ambiente" } @{ $res->{topics} } ),
            "Desenvolvimento Urbano E Meio Ambiente"
        );
    };

    rest_get "/api/topic/1", name => "list topics", stash => "topic";
    stash_test "topic" => sub {
        my $res = shift;

        is( $res->{topic}->{id}, 1, 'id=1' );
        is( $res->{topic}->{name}, "Desenvolvimento Humano", 'name' );

        is_deeply(
            [ sort keys %{ $res->{topic} } ],
            [ sort qw/ id name slug goals / ],
        );
    };
};

done_testing();
