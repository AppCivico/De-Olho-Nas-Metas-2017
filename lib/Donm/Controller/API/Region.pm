package Donm::Controller::API::Region;
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

sub base : Chained('root') : PathPart('region') : CaptureArgs(0) { }

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ($self, $c) = @_;

    my $region_rs = $c->stash->{collection}->search(
        {},
        {
            '+select' => [ \"ST_ASGEOJSON(ST_TRANSFORM(ST_SIMPLIFY(ST_TRANSFORM(geom, 2249), 100), 4326), 6)" ],
            '+as'     => [ qw(geo_json) ],
        }
    );

    return $self->status_ok(
        $c,
        entity => {
            region => [
                map {
                    my $r = $_;
                    +{
                        map { $_ => $r->get_column($_) }
                        qw/
                        id
                        name
                        geo_json
                        /
                    }
                } $region_rs->all()
            ],
        },
    );
}

__PACKAGE__->meta->make_immutable;

1;
