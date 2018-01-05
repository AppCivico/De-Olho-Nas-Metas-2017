package Donm::Controller::API::Region;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";
with "CatalystX::Eta::Controller::AutoResultGET";

__PACKAGE__->config(
    # AutoBase.
    result => "DB::Region",

    # AutoResultGET.
    object_key => "region",
    build_row  => sub {
        my ($region, $self, $c) = @_;

        return {
            region => {
                ( map { $_ => $region->$_ } qw/ id name subprefecture_id slug / ),

                subprefecture => +{
                    map { $_ => $region->subprefecture->$_ }
                      qw/ id acronym name slug latitude longitude site email telephone address /
                },

                variables => [
                    map {
                        +{
                            id     => $_->variable->get_column('id'),
                            name   => $_->variable->get_column('name'),
                            value  => $_->get_column('value'),
                            year   => $_->get_column('year'),
                            source => $_->get_column('source'),
                        }
                    } $region->region_variables->all()
                ],

                indicators => [
                    map {
                        +{
                            id               => $_->indicator->get_column('id'),
                            name             => $_->indicator->get_column('name'),
                            explanation      => $_->indicator->get_column('explanation'),
                            formula          => $_->indicator->get_column('formula'),
                            value            => $_->get_column('value'),
                            year             => $_->get_column('year'),
                            sources          => $_->get_column('sources'),
                            url_observatorio => $_->get_column('url_observatorio'),
                        }
                    } $region->region_indicators->all()
                ],
            }
        };
    },
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('region') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ($self, $c, $region_id) = @_;

    $c->stash->{region_id} = $region_id;

    my $region_rs = $c->stash->{collection}->search(
        {},
        { prefetch => [ "subprefecture", { "region_variables" => "variable" } ] },
    );

    if ( !( $c->stash->{region} = $region_rs->search( { 'me.id' => $region_id } )->next ) ) {
        $c->detach("/error_404");
    }
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ($self, $c) = @_;

    my $region_rs = $c->stash->{collection}->search(
        {},
        {
            prefetch  => [ "subprefecture" ],
            '+select' => [ \"ST_ASGEOJSON(ST_TRANSFORM(ST_SIMPLIFY(ST_TRANSFORM(geom, 2249), 25), 4326), 6)" ],
            '+as'     => [ qw(geo_json) ],
        }
    );

    return $self->status_ok(
        $c,
        entity => {
            regions => [
                map {
                    my $r = $_;
                    +{
                        (
                            map { $_ => $r->get_column($_) }
                            qw/
                            id
                            name
                            geo_json
                            subprefecture_id
                            slug
                            /
                        ),

                        subprefecture => +{
                            id   => $r->subprefecture->get_column('id'),
                            name => $r->subprefecture->get_column('name'),
                            slug => $r->subprefecture->get_column('slug'),
                        },
                    }
                } $region_rs->all()
            ],
        },
    );
}

sub result : Chained('object') : PathPart('') : Args(0) : ActionClass('REST') { }

sub result_GET { }

__PACKAGE__->meta->make_immutable;

1;
