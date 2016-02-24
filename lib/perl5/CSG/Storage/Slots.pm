package CSG::Storage::Slots;

use Modern::Perl;
use Moose;
use File::Spec;
use URI;
use Digest::SHA qw(sha1_hex);
use overload '""' => sub {shift->to_string};

use CSG::Storage::Slots::DB;
use CSG::Storage::Slots::Exceptions;
use CSG::Storage::Slots::Types;

has 'name'    => (is => 'ro', isa => 'ValidSlotName', required => 1);
has 'project' => (is => 'ro', isa => 'ValidProject',  required => 1);
has 'size'    => (is => 'ro', isa => 'ValidSlotSize', required => 1);

has 'sha1' => (is => 'ro', isa => 'Str', lazy => 1, builder => '_build_sha1');
has 'path' => (is => 'ro', isa => 'URI', lazy => 1, builder => '_build_path');

sub _build_sha1 {
  return sha1_hex(shift->name);
}

sub _build_path {
  my ($self) = @_;
  my $schema = CSG::Storage::Slots::DB->new();

  my $fs = $schema->resultset('Filesystem')->next_available;
  $fs->add_to_slots(
    {
      name       => $self->name,
      alloc_size => $self->size,
    }
  );

  my $path = File::Spec->join($fs->hostname, $fs->path, (split(//, $self->sha1))[0 .. 3], $self->name);

  CSG::Storage::Slots::Exceptions::SlotExists->throw() if -e $path;

  return URI->new($path);
}

sub to_string {
  return shift->path->as_string;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;
