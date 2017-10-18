package Donm::Controller::API::Subprefecture;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";
with "CatalystX::Eta::Controller::AutoBase";

__PACKAGE__->config(
    # AutoBase.
    result => "DB::Subprefecture",
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('subprefecture') : CaptureArgs(0) { }

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ($self, $c) = @_;

    $c->stash->{collection} = $c->stash->{collection}->search(
        { 'me.id' => { '-not_in' => [ 33, 34, 35 ] } },
        {
            join => [ "regions" ],
        },
    );

    return $self->status_ok(
        $c,
        entity => {
            subprefectures => [
                map {
                    my $s = $_;

                    +{
                        map { $_ => $s->get_column($_) } qw/ id name site email telephone address /
                    }
                } $c->stash->{collection}->all()
            ],
        },
    );
}

__PACKAGE__->meta->make_immutable;

1;
