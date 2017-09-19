#!/usr/bin/env perl
use common::sense;
use open ":locale";
use FindBin qw($RealBin $Script);
use lib "$RealBin/../../lib";

use DDP;
use Text::CSV;
use Tie::Handle::CSV;
use Donm::SchemaConnected;
use Log::Log4perl qw(:easy);

# Log.
Log::Log4perl->easy_init({
    file   => "STDOUT",
    layout => '[%d] [%p] %m%n',
    level  => $DEBUG,
    utf8   => 1,
}, {
    file   => ">>$RealBin/../../log/$Script.log",
    layout => '[%d] %m%n',
    level  => $DEBUG,
    utf8   => 1,
});

INFO "Iniciando $Script...";

my $schema = get_schema();

my $fh = Tie::Handle::CSV->new("$RealBin/../../dataset/relationship-goal-project.csv", header => 1);
#<$fh>;

$schema->txn_do(sub {
    while (my $line = <$fh>) {
        # Adicionando projeto.
        my $goal_id    = $line->{'ID Meta'};
        my $project_id = $line->{'ID Projeto'};

        my $action_line_ids = $line->{'ID Linha de Ação'};
        my ($action_line_id, $action_line_subid) = split m{\.}, $action_line_ids;

        next if $action_line_ids eq "20.4";

        my $project_action_line_rs = $schema->resultset("ProjectActionLine")->search(
            {
                'me.project_id'        => $project_id,
                'me.action_line_id'    => $action_line_id,
                'me.action_line_subid' => $action_line_subid,
            }
        );


        if (!$project_action_line_rs->next()) {
            $project_action_line_rs->create(
                {
                    project_id        => $project_id,
                    action_line_id    => $action_line_id,
                    action_line_subid => $action_line_subid,
                }
            );
        }

        print STDERR ".";
    }
    print STDERR "\n";
});

close $fh or LOGDIE $!;

INFO "Fim da execução.";

