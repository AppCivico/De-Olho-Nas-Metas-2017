package Donm::PlanejaSampa::Loader;
use common::sense;
use Moo;
with 'MooX::Singleton';

use MooX::Types::MooseLike::Base ':all';
use Text::CSV;
use File::Copy;
use File::Temp;

use Donm::Utils qw(slugify);
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

has _cache => (
    is   => 'ro',
    isa  => HashRef[HashRef[Int]],
    lazy => 1,
    builder => '_build_cache',
);

has _added_header => (
    is      => 'rw',
    isa     => HashRef[ArrayRef[Str]],
    default => sub { {} },
);

sub add {
    my ($self, $entity, $args) = @_;

    $self->_cache;
    if ($entity eq 'goal') {
        my $topic_name = delete $args->{topic};
        $args->{topic_id} = $self->_cache->{topic}->{$topic_name};

        $args->{slug} = slugify($args->{title});

        my $unit = delete $args->{unit};
        $args->{unit} = undef;
        $args->{unit} = 'unit' if $unit eq 'Unidade';
        $args->{unit} = '%'    if $unit eq '%';
        $args->{unit} = 'R$'   if $unit =~ m{^R\$};
    }
    elsif ($entity eq 'project') {
        $args->{slug} = slugify($args->{title});
    }
    elsif ($entity eq 'action_line') {
        $args->{slug} = slugify($args->{title});
    }
    elsif ($entity eq 'goal_execution') { }
    elsif ($entity eq 'goal_execution_subprefecture') {
        my $subprefecture_name = delete $args->{subprefecture_name};
        if (defined($subprefecture_name)) { $subprefecture_name =~ s/^PR\-//  }
        else                              { $subprefecture_name = 'A definir' }

        my $subprefecture_id = $self->_cache->{subprefecture}->{$subprefecture_name}
          or die "Unknown subprefecture '$subprefecture_name'";

        $args->{subprefecture_id} = $subprefecture_id;
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

            printf "Loading file '%s'\n", $fh->filename;

            # Copiando os dados para a tabela temporária.
            $dbh->do(qq{COPY $table_name ($columns) FROM $filepath WITH CSV HEADER QUOTE '"'});

            my $conflict = 'id';
            $conflict = join q{, }, qw(id_reference project_id)         if 'action_line'                  eq $entity;
            $conflict = join q{, }, qw(goal_id period accumulated)      if 'goal_execution'               eq $entity;
            $conflict = join q{, }, qw(goal_id subprefecture_id period) if 'goal_execution_subprefecture' eq $entity;

            # Atualizando os dados.
            my $upsert_query = <<"SQL_QUERY";
                INSERT INTO $original ($columns)
                SELECT $columns
                FROM $table_name
                ON CONFLICT ($conflict) DO UPDATE
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

    my $fh = File::Temp->new( UNLINK => 1, SUFFIX => '.csv', DIR => '/tmp' );
    binmode $fh, ':encoding(utf8)';
    chmod 0644, $fh->filename;

    return $fh;
}

sub _build_schema { return get_schema() }

sub _build_cache {
    my $self = shift;

    return {
        topic => +{
            map {
                my $topic_name = $_->get_column('name');
                $topic_name => $_->id
            } $self->schema->resultset('Topic')->all()
        },

        subprefecture => +{
            map {
                my $subprefecture = $_;
                $subprefecture->get_column('name') => $subprefecture->id
            } $self->schema->resultset('Subprefecture')->all()
        }
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

