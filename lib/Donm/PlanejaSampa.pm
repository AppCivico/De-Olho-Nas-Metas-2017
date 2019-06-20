package Donm::PlanejaSampa;
use common::sense;
use Moo;
use MooX::Types::MooseLike::Base ':all';

use YADA;
use Donm::PlanejaSampa::Loader;
use Donm::PlanejaSampa::Worker;

has loader => (
    is      => 'rw',
    isa     => InstanceOf['Donm::PlanejaSampa::Loader'],
    lazy    => 1,
    builder => '_build_loader',
);

has yada => (
    is      => 'rw',
    isa     => InstanceOf['YADA'],
    lazy    => 1,
    builder => '_build_yada'
);

sub synchronize {
    my ($self) = @_;

    $self->yada->append(sub {
        Donm::PlanejaSampa::Worker->new({
            initial_url => 'http://planejasampa.prefeitura.sp.gov.br/api/metas',
            action      => 'index',
            retry       => 3,
        });
    });

    for my $project_id ( 1 .. 75 ) {
        $self->yada->append(sub {
            Donm::PlanejaSampa::Worker->new({
                initial_url => "http://planejasampa.prefeitura.sp.gov.br/api/projetos/${project_id}",
                action      => 'project',
                retry       => 3,
            });
        });
    }

    $self->yada->wait();
    $self->loader->load_all();

    return 0;
}

sub _build_loader { return Donm::PlanejaSampa::Loader->instance }

sub _build_yada {
    return YADA->new(
        max        => 4,
        allow_dups => 0,
        timeout    => 30,
    );
}

1;
