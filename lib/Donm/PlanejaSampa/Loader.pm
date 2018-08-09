package Donm::PlanejaSampa::Loader;
use common::sense;
use Moo;
with 'MooX::Singleton';

use MooX::Types::MooseLike::Base ':all';
use Text::CSV;
use File::Copy;
use File::Temp;

use Donm::SchemaConnected qw(get_schema);

use Data::Printer;

has schema => (
    is   => 'rw',
    lazy => 1,
    builder => '_build_schema',
);

has _filehandles => (
    is      => 'rw',
    isa     => HashRef[InstanceOf['File::Temp']],
    default => sub { {} },
);

has csv => (
    is   => 'rw',
    isa  => InstanceOf['Text::CSV'],
    lazy => 1,
    builder => '_build_csv',
);

has _cache_topics => (
    is   => 'rw',
    isa  => HashRef[Int],
    lazy => 1,
    builder => '_build_cache_topics',
);

has _added_header => (
    is      => 'rw',
    isa     => HashRef[ArrayRef[Str]],
    default => sub { {} },
);

sub add {
    my ($self, $entity, $args) = @_;

    if ($entity eq 'goal') {
        $self->_cache_topics; # Build topics cache.

        my $topic_name = delete $args->{topic};
        $args->{topic_id} = $self->_cache_topics->{$topic_name};
    }
    else { die "die invalid entity '$entity'" }

    my $fh = $self->get_filehandle($entity);

    my @columns = sort keys %{$args};

    if (!exists($self->_added_header->{$entity})) {
        $self->csv->print($fh, \@columns);
        $self->_added_header->{$entity} = \@columns;
    }

    $self->csv->print(
        $fh,
        [ map { $args->{$_ } } @columns ]
    );

    return 1;
}

sub get_filehandle {
    my ($self, $entity) = @_;

    if (!exists($self->_filehandles->{$entity})) {
        $self->_filehandles->{$entity} = $self->_get_new_fh();
    }
    return $self->_filehandles->{$entity};
}

sub _get_new_fh {
    my $self = shift;

    my $fh = File::Temp->new( UNLINK => 0, SUFFIX => '.csv', DIR => '/home/junior/projects/De-Olho-Nas-Metas-2017/tmp/' );
    binmode $fh, ':encoding(utf8)';

    return $fh;
}

sub _build_schema { return get_schema() }

sub _build_cache_topics {
    my ($self) = @_;

    return +{
        map {
            my $topic_name = $_->get_column('name');
            $topic_name => $_->id
        } $self->schema->resultset('Topic')->all()
    };
}

sub _build_csv {
    return Text::CSV->new({
        binary       => 1,
        eol          => "\n",
        escape_char  => '"',
        quote_char   => '"',
        sep_char     => ",",
        always_quote => 1,
        auto_diag    => 1,
    });
}

__PACKAGE__->meta->make_immutable;

1;

