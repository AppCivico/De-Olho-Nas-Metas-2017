package Donm::Controller::API::SaoPaulo;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";

__PACKAGE__->config(
    # AutoBase.
    result => "DB::Region",
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('sao-paulo') : CaptureArgs(0) { }

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ($self, $c) = @_;

    return $self->status_ok(
        $c,
        entity => {
            sao_paulo => {
                geo_json => $c->stash->{collection}->search(
                    {},
                    {
                        select => [ \"ST_ASGEOJSON(ST_TRANSFORM(ST_SIMPLIFY(ST_TRANSFORM(ST_UNION(me.geom), 2249), 25), 4326), 6)" ],
                        as     => [ "geo_json" ],
                    },
                )->next->get_column('geo_json'),
            }
        },
    );
}

__PACKAGE__->meta->make_immutable;

1;
