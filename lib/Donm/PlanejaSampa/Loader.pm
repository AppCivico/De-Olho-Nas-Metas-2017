package Donm::PlanejaSampa::Loader;
use common::sense;
use Moo;
with 'MooX::Singleton';

use MooX::Types::MooseLike::Base ':all';
use Encode 'encode_utf8';
use Text::CSV;
use File::Copy;
use File::Temp;
use File::Slurper 'read_text';
use Digest::SHA qw(sha256_hex);

use Donm::Utils qw(slugify);
use Donm::SchemaConnected qw(get_schema);

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
    is   => 'rw',
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

    $args->{$_} =~ s/(^\s+|\s+$)//g for keys %{$args}; # Trim.

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

        my $secretariat_name = delete $args->{secretariat_name};
        $args->{secretariat_id} = $self->_cache->{secretariat}->{$secretariat_name};
    }
    elsif ($entity eq 'project') {
        $args->{slug} = slugify($args->{title});
    }
    elsif ($entity eq 'action_line') {
        $args->{slug} = slugify($args->{title});
    }
    elsif ($entity eq 'goal_project')                   {}
    elsif ($entity eq 'goal_execution')                 {}
    elsif ($entity eq 'action_line_execution')          {}
    elsif ($entity eq 'project_budget_execution')       {}
    elsif ($entity eq 'goal_additional_information')    {}
    elsif ($entity eq 'project_additional_information') {
        my $description = $args->{description};
        $args->{hash} = sha256_hex(encode_utf8($description));
    }
    elsif ($entity eq 'goal_execution_subprefecture') {
        my $subprefecture_name = delete $args->{subprefecture_name};
        if (defined($subprefecture_name)) { $subprefecture_name =~ s/^PR\-//  }
        else                              { $subprefecture_name = 'A definir' }

        my $subprefecture_id = $self->_cache->{subprefecture}->{$subprefecture_name}
          or die "Unknown subprefecture '$subprefecture_name'";

        $args->{subprefecture_id} = $subprefecture_id;
    }
    elsif ($entity eq 'badge') {
        my $name = delete $args->{name};
        $name =~ s/^[0-9]+\s+\-\s+//g;
        $args->{name} = $name;
    }
    elsif ($entity eq 'goal_badge') {
        my $badge = delete $args->{badge_name};
        $badge =~ s/^[0-9]+\s+\-\s+//g;
        my $badge_id = $self->_cache->{badge}->{$badge};
        if (!$badge_id) {
            $self->_cache($self->_build_cache());
            my $badge_id = $self->_cache->{badge}->{$badge} or die "Unknown badge '$badge'";
        }
        $args->{badge_id} = $badge_id;

    }
    elsif ($entity eq 'project_badge') {
        my $badge = delete $args->{badge_name};
        $badge =~ s/^[0-9]+\s+\-\s+//g;
        my $badge_id = $self->_cache->{badge}->{$badge};
        if (!$badge_id) {
            $self->_cache($self->_build_cache());
            my $badge_id = $self->_cache->{badge}->{$badge} or die "Unknown badge '$badge'";
        }
        $args->{badge_id} = $badge_id;
    }
    elsif ($entity eq 'action_line_execution_subprefecture') {
        my $subprefecture_name = delete $args->{subprefecture_name};
        $args->{subprefecture_id} = $self->_cache->{subprefecture}->{$subprefecture_name};
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
        [
            map {
                my $value = $args->{$_};
                $value =~ s/\R/\n/g if defined $value;
                $value;
            } @columns
        ]
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

    my @entities = qw(
        badge project goal action_line goal_project goal_badge project_badge goal_execution goal_additional_information
        goal_execution_subprefecture project_additional_information project_budget_execution action_line_execution
        action_line_execution_subprefecture
    );
    for my $entity (@entities) {
        my $fh = $self->_filehandles->{$entity} or die die "There is no entity '$entity'.";
        printf "Loading entity '%s'...\n", $entity;
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

            $dbh->do(qq{CREATE TEMPORARY TABLE $table_name ( LIKE $original INCLUDING DEFAULTS INCLUDING CONSTRAINTS INCLUDING STORAGE)});

            my $filepath = $dbh->quote($fh->filename);
            my @columns  = @{ $self->_added_header->{$entity} };
            my $columns  = join(q{, }, @columns);

            printf "Loading file '%s'...\n", $fh->filename;

            # Copiando os dados para a tabela temporária.
            $dbh->do(qq{COPY $table_name ($columns) FROM stdin WITH CSV HEADER QUOTE '"';});

            $dbh->pg_putcopydata(read_text($fh->filename));
            $dbh->pg_putcopyend();

            my $conflict = 'id';
            $conflict = join q{, }, qw(name)                                                                    if 'badge'                               eq $entity;
            $conflict = join q{, }, qw(goal_id badge_id)                                                        if 'goal_badge'                          eq $entity;
            $conflict = join q{, }, qw(id_reference project_id)                                                 if 'action_line'                         eq $entity;
            $conflict = join q{, }, qw(goal_id project_id)                                                      if 'goal_project'                        eq $entity;
            $conflict = join q{, }, qw(project_id badge_id)                                                     if 'project_badge'                       eq $entity;
            $conflict = join q{, }, qw(goal_id period accumulated)                                              if 'goal_execution'                      eq $entity;
            $conflict = join q{, }, qw(action_line_project_id action_line_id_reference period accumulated)      if 'action_line_execution'               eq $entity;
            $conflict = join q{, }, qw(project_id year)                                                         if 'project_budget_execution'            eq $entity;
            $conflict = join q{, }, qw(goal_id description)                                                     if 'goal_additional_information'         eq $entity;
            $conflict = join q{, }, qw(goal_id subprefecture_id period)                                         if 'goal_execution_subprefecture'        eq $entity;
            $conflict = join q{, }, qw(project_id hash)                                                         if 'project_additional_information'      eq $entity;
            $conflict = join q{, }, qw(action_line_project_id action_line_id_reference period subprefecture_id) if 'action_line_execution_subprefecture' eq $entity;

            # Atualizando os dados.
            my $upsert_query = <<"SQL_QUERY";
                INSERT INTO $original ($columns)
                SELECT DISTINCT ON($conflict) $columns
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

    my $fh = File::Temp->new( UNLINK => 0, SUFFIX => '.csv', DIR => '/tmp' );
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
        },

        badge => +{
            map {
                $_->get_column('name') => $_->id
            } $self->schema->resultset('Badge')->all()
        },

        secretariat => +{
            map {
                $_->get_column('name') => $_->id
            } $self->schema->resultset('Secretariat')->all()
        },

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
