package Test::CSG::Storage::Slots;

use base qw(Test::Class);
use Test::More;

use Modern::Perl;
use YAML qw(LoadFile);
use Data::Dumper;

use CSG::Storage::Slots;
use CSG::Storage::Slots::DB;

sub class {
  return 'CSG::Storage::Slots';
}

sub startup : Test(startup) {
  my ($self) = @_;

  my $schema = CSG::Storage::Slots::DB->new();
  $schema->deploy({add_drop_table => 1});

  my $filesystems = LoadFile(qq{$FindBin::Bin/../t/fixtures/filesystems.yml});

  for my $filesystem (@{$filesystems}) {
    my $type = $schema->resultset('Type')->find_or_create({name => $filesystem->{type}});
    my $project = $schema->resultset('Project')->find_or_create({name => $filesystem->{project}});

    $schema->resultset('Filesystem')->find_or_create(
      {
        name            => $filesystem->{name},
        hostname        => $filesystem->{hostname},
        current_storage => $filesystem->{current_storage},
        alloc_storage   => $filesystem->{alloc_storage},
        total_storage   => $filesystem->{total_storage},
        type_id         => $type->id,
        project_id      => $project->id,
      }
    );
  }
}

sub setup : Test(setup => 1) {
  my ($self) = @_;

  my $slot = $self->class->new(
    name    => 'foo',
    project => 'topmed',
    size    => '300GB',
  );

  isa_ok($slot, $self->class);
  $self->{stash}->{slot} = $slot;
}

sub teardown : Test(teardown) {

  # TODO - purge database records
}

sub test_path : Test(1) {
  my ($self) = @_;
  my $slot = $self->{stash}->{slot};

  is($slot->to_string, '/tmp/foo', 'path matches');
}

# TODO - test to write
#   * new - with valid/invalid projects/sizes/names and duplicates
#   * path - path returns expected uri
#   * to_string - return valid and expected path
#   * stringification overload thingus
#

1;
