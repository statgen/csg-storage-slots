package Test::CSG::Storage::Slots;

use base qw(Test::Class);
use Test::More;
use Test::Exception;

use FindBin;
use Modern::Perl;
use YAML qw(LoadFile);
use Data::Dumper;
use Digest::SHA qw(sha1_hex);

use CSG::Storage::Slots;
use CSG::Storage::Slots::DB;

sub class {
  return 'CSG::Storage::Slots';
}

sub startup : Test(startup) {
  my ($self) = @_;

  my $schema = CSG::Storage::Slots::DB->new();

  diag("Deploying schema to $ENV{SLOTS_DB}"); # TODO - replace %ENV with config lookup or something
  $schema->deploy({add_drop_table => 1});

  my $filesystems = LoadFile(qq{$FindBin::Bin/../t/fixtures/filesystems.yml});

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

    $self->{stash}->{fixture} = $filesystems;
  }
}

sub test_new : Test(5) {
  my ($self) = @_;

  throws_ok {$self->class->new()} 'Moose::Exception::AttributeIsRequired', 'missing all params for new()';
  throws_ok {$self->class->new(name => 'foobar')} 'Moose::Exception::AttributeIsRequired', 'missing project and size for new()';
  throws_ok {$self->class->new(name => 'foobar', project => 'proj1')} 'Moose::Exception::AttributeIsRequired',
    'missing size for new()';

  lives_ok {$self->class->new(name => 'foobar', project => 'proj1', size => '100T')} 'all params given for new()';

  throws_ok {$self->class->new(name => 'foo', project => 'foo', size => '100T')}
  'Moose::Exception::ValidationFailedForInlineTypeConstraint', 'invalid project name';
}

sub test_path : Test(2) {
  my ($self) = @_;

  my $slot = $self->class->new(
    name    => 'foobar',
    project => 'proj1',
    size    => '300GB',
  );

  like($slot->to_string, qr{^foo[1|2]\.localhost/working/slots[1|2]/8/8/4/3/foo}, 'to_string() path matches');
  like("$slot", qr{^foo[1|2]\.localhost/working/slots[1|2]/8/8/4/3/foo}, 'stringification path matches');
}

sub test_sha1 : Test(1) {
  my ($self) = @_;
  my $name   = 'foobarbaz';
  my $slot   = $self->class->new(name => $name, project => 'proj1', size => '200GB');

  is($slot->sha1, sha1_hex($name), 'SHA1 should match');
}

1;
