package Donm::Controller::API::ActionLine;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";
with "CatalystX::Eta::Controller::AutoListGET";
with "CatalystX::Eta::Controller::AutoResultGET";

use DDP;

__PACKAGE__->config(
    # AutoBase.
    result => 'DB::ActionLine',

    # AutoListGET.
    list_key => 'action_lines',
    build_list_row => sub {
        my ($r, $self, $c) = @_;

        return {
            id                    => $r->get_exhibition_id(),
            achievement           => $r->get_column('achievement'),
            title                 => $r->get_column('title'),
            indicator_description => $r->get_column('indicator_description'),
        };
    },

    object_key => 'action_line',
    build_row  => sub {
        my ($action_line, $self, $c) = @_;

        return {
            action_line => {
                id                    => $action_line->get_exhibition_id(),
                achievement           => $action_line->get_column('achievement'),
                title                 => $action_line->get_column('title'),
                indicator_description => $action_line->get_column('indicator_description'),

                subprefectures => [
                    map {
                        +{
                            id   => $_->subprefecture->get_column('id'),
                            name => $_->subprefecture->get_column('name'),
                            slug => $_->subprefecture->get_column('slug'),
                        };
                    } $action_line->subprefecture_action_lines->all()
                ],
            },
        },
    },
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('action-line') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ($self, $c, $exhibition_id) = @_;

    $c->stash->{collection} = $c->stash->{collection}->search( {}, { prefetch => [ { "subprefecture_action_lines" => "subprefecture" } ] } );
    if ( !( $c->stash->{action_line} = $c->stash->{collection}->search_by_exhibition_id($exhibition_id)->next ) ) {
        $c->detach("/error_404");
    }
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET { }

sub result : Chained('object') : PathPart('') : Args(0) : ActionClass('REST') { }

sub result_GET { }

__PACKAGE__->meta->make_immutable;

1;
