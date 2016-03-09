package Test::CSG::Storage::Base;

use base qw(Test::Class);
use Test::More;

use Modern::Perl;
use File::Path qw(remove_tree);
use File::Spec;
use File::Temp qw(tempdir);
use YAML qw(LoadFile);

use CSG::Storage::Slots::DB;

my $PREFIX = tempdir();

sub fixture_path {
  return qq{$FindBin::Bin/../t/fixtures};
}

sub prefix {
  return $PREFIX;
}

sub _startup : Test(startup) {
  my ($self) = @_;

  my $schema = CSG::Storage::Slots::DB->new();

  diag("Deploying schema to $ENV{SLOTS_DB}"); # TODO - replace %ENV with config lookup or something
  $schema->deploy({add_drop_table => 1});

  my $filesystems = LoadFile(File::Spec->join($self->fixture_path, 'filesystems.yml'));

  for my $filesystem (@{$filesystems}) {
    diag("Creating type: $filesystem->{type}");
    my $type = $schema->resultset('Type')->find_or_create({name => $filesystem->{type}});

    diag("Creating project: $filesystem->{project}");
    my $project = $schema->resultset('Project')->find_or_create({name => $filesystem->{project}});

    diag("Creating filesystem: $filesystem->{name}");
    my $fs = $schema->resultset('Filesystem')->find_or_create(
      {
        name       => $filesystem->{name},
        hostname   => $filesystem->{hostname},
        size_used  => $filesystem->{size_used},
        size_total => $filesystem->{size_total},
        path       => $filesystem->{path},
        type_id    => $type->id,
        project_id => $project->id,
      }
    );

    for my $slot (@{$filesystem->{slots}}) {
      diag("Creating slot: $slot->{name}");
      $fs->add_to_slots(
        {
          name => $slot->{name},
          size => $slot->{size},
        }
      );
    }
  }
}

sub _teardown : Test(teardown) {
  remove_tree(shift->prefix, {verbose => 1, keep_root => 0});
}

1;
