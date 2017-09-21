package Donm::Controller::API::Goal;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";

__PACKAGE__->config(
    # AutoBase.
    result => "DB::Goal",
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('goal') : CaptureArgs(0) { }

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ($self, $c) = @_;

    return $self->status_ok(
        $c,
        entity => {
            goal => [
                map {
                    my $r = $_;
                    +{
                        ( map { $_ => $r->{$_} } qw/ id title topic_id topic / ),

                        topic => +{ map { $_ => $r->{topic}->{$_} } qw/ id name / },

                        goal_projects => [
                            map {
                                my $gp = $_;
                                +{
                                    ( map { $_ => $gp->{$_} } qw/ id goal_id project_id / ),

                                    project => +{ map { $_ => $gp->{project}->{$_} } qw/ id title / },
                                }
                            } @{ $r->{goal_projects} }
                        ],
                    }
                } $c->stash->{collection}->search(
                    {},
                    {
                        prefetch     => [ "topic", { 'goal_projects' => "project" } ],
                        result_class => "DBIx::Class::ResultClass::HashRefInflator",
                    }
                )->all()
            ],
        },
    );
}

__PACKAGE__->meta->make_immutable;

1;
