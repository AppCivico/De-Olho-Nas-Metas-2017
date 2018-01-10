package Donm::Controller::API::Variable;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";

__PACKAGE__->config(
    # AutoBase.
    result      => "DB::Variable",
    result_attr => { prefetch => [ { region_variables => 'region' } ] },
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('variable') : CaptureArgs(0) { }

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ($self, $c) = @_;

    return $self->status_ok(
        $c,
        entity => {
            variables => [
                map {
                    +{
                        id   => $_->get_column('id'),
                        name => $_->get_column('name'),

                        regions => [
                            map {
                                +{
                                    id     => $_->region->get_column('id'),
                                    name   => $_->region->get_column('name'),
                                    value  => $_->get_column('value'),
                                    year   => $_->get_column('year'),
                                    source => $_->get_column('source'),
                                }
                            } $_->region_variables->all()
                        ],
                    }
                } $c->stash->{collection}->all()
            ]
        },
    );
}


__PACKAGE__->meta->make_immutable;

1;
