package Donm::Controller::API::Secretariats;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";
with "CatalystX::Eta::Controller::AutoListGET";

__PACKAGE__->config(
    # AutoBase.
    result      => 'DB::Secretariat',
    result_attr => { order_by => [ 'me.id' ] },

    # AutoListGET.
    list_key => 'secretariats',
    build_list_row => sub {
        my $r = shift;
        +{
            id   => $r->get_column('id'),
            name => $r->get_column('name'),
        }
    },
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('secretariats') : CaptureArgs(0) { }

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET { }

__PACKAGE__->meta->make_immutable;

1;
