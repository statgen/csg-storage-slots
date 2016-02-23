package CSG::Storage::Slots;

use Modern::Perl;
use Moose;
use File::Spec;
use URI;
use overload '""' => sub { shift->to_string };

use CSG::Storage::Slots::DB;

has 'name'    => (is => 'ro', isa => 'Str', required => 1);    # TODO - test for duplicates
has 'project' => (is => 'ro', isa => 'Str', required => 1);    # TODO - validate with known groups via type
has 'size'    => (is => 'ro', isa => 'Str', required => 1);    # TODO - make human readable filesystem size i.e. 250GB

has 'path'    => (is => 'ro', isa => 'URI', lazy => 1, builder => '_build_path');

# TODO - find next available slot
sub _build_path {
  my ($self) = @_;
  my $schema = CSG::Storage::Slots::DB->new();

  return URI->new(File::Spec->join('/tmp', shift->name));
}

sub to_string {
  return shift->path->as_string;
}


no Moose;
__PACKAGE__->meta->make_immutable;

1;
