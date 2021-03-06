use common::sense;
use FindBin qw($Bin);
use lib "$Bin/../lib";
use Donm::Test::Further;

use Encode;

my $schema = Donm->model("DB");

db_transaction {
    subtest 'download goals' => sub {

        my $req = request('/download/goals');
        ok $req->is_success, 'request success';
        is $req->code, 200,  'response_code=200';

        my $content = decode_utf8 $req->decoded_content;
        like $content, qr{^\Q"ID","NOME","EIXO","SECRETARIA","PROJEÇÃO","INDICADOR","VALOR BASE","STATUS"};
    };

    subtest 'download projects' => sub {

        my $req = request('/download/projects');
        ok $req->is_success, 'request success';
        is $req->code, 200,  'response_code=200';

        my $content = decode_utf8 $req->decoded_content;
        like $content, qr{^\Q"ID","NOME","DESCRIÇÃO","RESULTADOS ESPERADOS"};
    };

    subtest 'download action lines' => sub {

        my $req = request('/download/action-lines');
        ok $req->is_success, 'request success';
        is $req->code, 200,  'response_code=200';

        my $content = decode_utf8 $req->decoded_content;
        like $content, qr{^\Q"ID","NOME","STATUS","PROJETO","INDICADOR","DESCRIÇÃO_INDICADOR","OBJETIVO"};
    };
};

done_testing();

