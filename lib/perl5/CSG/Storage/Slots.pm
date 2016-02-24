package CSG::Storage::Slots;

use Modern::Perl;
use Moose;
use File::Spec;
use URI;
use overload '""' => sub {shift->to_string};

use CSG::Storage::Slots::DB;
use CSG::Storage::Slots::Exceptions;
use CSG::Storage::Slots::Types;

has 'name'    => (is => 'ro', isa => 'ValidSlotName', required => 1);
has 'project' => (is => 'ro', isa => 'ValidProject',  required => 1);
has 'size'    => (is => 'ro', isa => 'ValidSlotSize', required => 1);

has 'path' => (is => 'ro', isa => 'URI', lazy => 1, builder => '_build_path');

sub _build_path {
  my ($self) = @_;
  my $schema = CSG::Storage::Slots::DB->new();

  # TODO - determine next available filesystem
  #      - record slot
  my $fs = $schema->resultset('Filesystem')->search({}, {order_by => 'rand()', limit => 1})->first;

  return URI->new(File::Spec->join($fs->path, $self->name));
}

sub to_string {
  return shift->path->as_string;
}


no Moose;
__PACKAGE__->meta->make_immutable;

1;
