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
    isa  => InstanceOf['Donm::Schema', 'DBIx::Class::Schema'],
    lazy => 1,
    builder => '_build_schema',
);

has csv => (
    is   => 'rw',
    isa  => InstanceOf['Text::CSV'],
    lazy => 1,
    builder => '_build_csv',
);

has _filehandles => (
    is      => 'rw',
    isa     => HashRef[InstanceOf['File::Temp']],
    default => sub { {} },
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

sub load_all {
    my $self = shift;

    for my $entity (keys %{ $self->_filehandles }) {
        my $fh = $self->_filehandles->{$entity};

        $self->load_file($entity, $fh);
    }
    return;
}

sub load_file {
    my ($self, $entity, $fh) = @_;

    $self->schema->txn_do(sub {
        close $fh or die $!;

        $self->schema->storage->dbh_do(sub {
            my ($storage, $dbh) = @_;

            # Criando uma tabela temporária para inserir os dados.
            my $table_name = $dbh->quote_identifier(sprintf("%s_%s", $entity, $self->_get_random_string()));
            my $original = $dbh->quote_identifier($entity);

            $dbh->do(qq{CREATE TEMPORARY TABLE $table_name ( LIKE $original INCLUDING ALL )});

            my $filepath = $dbh->quote($fh->filename);
            my @columns  = @{ $self->_added_header->{$entity} };
            my $columns  = join(q{, }, @columns);

            # Copiando os dados para a tabela temporária.
            $dbh->do(qq{COPY $table_name ($columns) FROM $filepath WITH CSV HEADER QUOTE '"'});

            # Atualizando os dados.
            my $upsert_query = <<"SQL_QUERY";
                INSERT INTO $original ($columns)
                SELECT $columns
                FROM $table_name
                ON CONFLICT (id) DO UPDATE
                SET
                updated_at = NOW(),
SQL_QUERY
            $upsert_query .= join qq{,\n}, map { qq{$_ = EXCLUDED.$_}  } @columns;
            return $dbh->do($upsert_query);
        });
    });

    return 1;
}

sub _get_random_string {
    my @chars = (0 .. 9, "a".."z");
    my $string;
    $string .= $chars[rand @chars] for 1..8;

    return $string;
}

sub _get_new_fh {
    my $self = shift;

    my $fh = File::Temp->new( UNLINK => 1, SUFFIX => '.csv', DIR => '/home/junior/projects/De-Olho-Nas-Metas-2017/tmp/' );
    binmode $fh, ':encoding(utf8)';
    chmod 0777, $fh->filename;

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

