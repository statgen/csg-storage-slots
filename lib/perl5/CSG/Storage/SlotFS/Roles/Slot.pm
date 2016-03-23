package CSG::Storage::SlotFS::Roles::Slot;

use autodie qw(:all);
use Moose::Role;

use Modern::Perl;
use File::Spec;
use overload '""' => sub {shift->to_string};

use CSG::Storage::Slots;
use CSG::Storage::Types;

requires qw(initialize list_paths);

has 'name' => (
  is       => 'ro',
  isa      => 'Str',
  required => 1
);

has 'project' => (
  is       => 'ro',
  isa      => 'Str',
  required => 1
);

has 'prefix' => (
  is      => 'ro',
  isa     => 'ValidPrefixPath',
  default => sub {'/net'}
);

has 'path' => (
  is      => 'ro',
  isa     => 'Str',
  lazy    => 1,
  builder => '_build_path'
);

has '_slot' => (
  is      => 'ro',
  isa     => 'CSG::Storage::Slots',
  lazy    => 1,
  builder => '_build_slot',
);

sub _build_slot {
  my ($self) = @_;

  return CSG::Storage::Slots->find(
    name    => $self->name,
    project => $self->project,
  );
}

sub _build_path {
  my ($self) = @_;
  return File::Spec->join($self->prefix, $self->_slot->path);
}

sub to_string {
  return shift->path;
}

1;
