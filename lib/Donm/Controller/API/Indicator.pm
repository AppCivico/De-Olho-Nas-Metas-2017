package Donm::Controller::API::Indicator;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";

__PACKAGE__->config(
    # AutoBase.
    result      => "DB::Indicator",
    result_attr => { prefetch => [ { region_indicators => 'region' } ] },
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('indicator') : CaptureArgs(0) { }

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ($self, $c) = @_;

    return $self->status_ok(
        $c,
        entity => {
            indicators => [
                map {
                    +{
                        id          => $_->get_column('id'),
                        name        => $_->get_column('name'),
                        explanation => $_->get_column('explanation'),
                        formula     => $_->get_column('formula'),

                        regions => [
                            map {
                                +{
                                    id      => $_->region->get_column('id'),
                                    name    => $_->region->get_column('name'),
                                    value   => $_->get_column('value'),
                                    year    => $_->get_column('year'),
                                    sources => $_->get_column('sources'),
                                    url_observatorio => $_->get_column('url_observatorio'),
                                }
                            } $_->region_indicators->all()
                        ],
                    }
                } $c->stash->{collection}->all()
            ]
        },
    );
}

__PACKAGE__->meta->make_immutable;

1;
