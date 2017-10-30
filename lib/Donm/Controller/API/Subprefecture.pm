package Donm::Controller::API::Subprefecture;
use common::sense;
use Moose;
use namespace::autoclean;

BEGIN { extends 'CatalystX::Eta::Controller::REST' }

with "CatalystX::Eta::Controller::AutoBase";
with "CatalystX::Eta::Controller::AutoResultGET";

__PACKAGE__->config(
    # AutoBase.
    result => 'DB::Subprefecture',
    result_cond => { 'me.id' => { '-not_in' => [ 33, 34, 35 ] } },

    # AutoResultGET.
    object_key => 'subprefecture',
    build_row  => sub {
        my ($subprefecture, $self, $c) = @_;

        return {
            subprefecture => {
                ( map { $_ => $subprefecture->get_column($_) } qw/ id acronym name site email telephone address slug / ),

                action_lines_count => $subprefecture->get_action_lines_count(),

                regions => [
                    map {
                        my $r = $_;
                        +{
                            id   => $r->get_column('id'),
                            name => $r->get_column('name'),
                            slug => $r->get_column('slug'),
                        };
                    } $subprefecture->regions->all()
                ],

                action_lines => [
                    map {
                        +{
                            id                    => $_->action_line->get_exhibition_id(),
                            title                 => $_->action_line->get_column('title'),
                            indicator_description => $_->action_line->get_column('indicator_description'),
                            achievement           => $_->action_line->get_column('achievement'),
                        }
                    } $subprefecture->subprefecture_action_lines->all()
                ],
            }
        };
    },
);

sub root : Chained('/api/root') : PathPart('') : CaptureArgs(0) { }

sub base : Chained('root') : PathPart('subprefecture') : CaptureArgs(0) { }

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ($self, $c, $subprefecture_id) = @_;

    $c->stash->{collection} = $c->stash->{collection}->search( {}, { prefetch => [ "regions", { "subprefecture_action_lines" => "action_line" } ] } );

    if ( !( $c->stash->{subprefecture} = $c->stash->{collection}->search( { 'me.id' => $subprefecture_id } )->next ) ) {
        $c->detach("/error_404");
    }
}

sub list : Chained('base') : PathPart('') : Args(0) : ActionClass('REST') { }

sub list_GET {
    my ($self, $c) = @_;

    $c->stash->{collection} = $c->stash->{collection}->search(
        {},
        {
            '+select' => [ \"ST_ASGEOJSON(ST_TRANSFORM(ST_SIMPLIFY(ST_TRANSFORM(ST_UNION(regions.geom), 2249), 25), 4326), 6)" ],
            '+as'     => [ qw/ geo_json/ ],
            join      => [ qw/ regions / ],
            group_by  => [ 'me.id' ],
        },
    );

    return $self->status_ok(
        $c,
        entity => {
            subprefectures => [
                map {
                    my $s = $_;

                    +{
                        ( map { $_ => $s->get_column($_) } qw/ id name site email telephone address geo_json slug / ),

                        action_lines_count => $s->get_action_lines_count(),

                        regions => [
                            map {
                                my $r = $_;

                                +{
                                    id   => $r->get_column('id'),
                                    name => $r->get_column('name'),
                                    slug => $r->get_column('slug'),
                                }
                            } $s->regions->all()
                        ],
                    }
                } $c->stash->{collection}->all()
            ],
        },
    );
}

sub result : Chained('object') : PathPart('') : Args(0) : ActionClass('REST') { }

sub result_GET { }

__PACKAGE__->meta->make_immutable;

1;
