package CSG::Storage::Slots;

use Modern::Perl;
use Moose;
use File::Spec;
use URI;

# TODO setup overload for stringification

has 'name'    => (is => 'ro', isa => 'Str', required => 1);    # TODO - test for duplicates
has 'project' => (is => 'ro', isa => 'Str', required => 1);    # TODO - validate with known groups via type
has 'size'    => (is => 'ro', isa => 'Str', required => 1);    # TODO - make human readable filesystem size i.e. 250GB
has 'path' => (is => 'ro', isa => 'URI', lazy => 1, builder => '_build_path');

sub _build_path {
  return URI->new(File::Spec->join('/tmp', shift->name));
}

sub to_string {
  return shift->path->as_string;
}


no Moose;
__PACKAGE__->meta->make_immutable;

1;
