package Donm::Controller::API::ActionLine;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";
with "CatalystX::Eta::Controller::AutoListGET";

use DDP;

__PACKAGE__->config(
    # AutoBase.
    result => 'DB::ActionLine',

    # AutoListGET.
    list_key => 'action_lines',
    build_list_row => sub {
        my ($r, $self, $c) = @_;
        +{
            id                    => $r->get_real_id(),
            achievement           => $r->get_column('achievement'),
            title                 => $r->get_column('title'),
            indicator_description => $r->get_column('indicator_description'),
        };
    },
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('action-line') : CaptureArgs(0) { }

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET { }

__PACKAGE__->meta->make_immutable;

1;
