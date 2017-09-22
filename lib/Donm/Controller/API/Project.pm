package Donm::Controller::API::Project;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";

__PACKAGE__->config(
    # AutoBase.
    result => "DB::Project",
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('project') : CaptureArgs(0) { }

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ($self, $c) = @_;

    my @all = $c->stash->{collection}->search(
        {},
        { prefetch => [ { 'goal_projects' => { "goal" => "topic" } } ], result_class => "DBIx::Class::ResultClass::HashRefInflator" },
    )->all;

    use DDP;
    p \@all;

    return $self->status_ok(
        $c,
        entity => {
            projects => [
                map {
                    my $r = $_;
                    +{
                        ( map { $_ => $r->$_ } qw/ id title / ),
                        (
                            topics => [
                                #map {
                                #    my $gp = $_;

                                #    +{};
                                #} $r->goal_projects
                            ],
                        ),
                    };
                } $c->stash->{collection}->search(
                    {},
                    { join => { 'goal_projects' => "goal" } },
                )->all()
            ],
        },
    );
}

__PACKAGE__->meta->make_immutable;

1;
