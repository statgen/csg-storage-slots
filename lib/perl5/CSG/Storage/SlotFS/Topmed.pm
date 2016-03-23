package CSG::Storage::SlotFS::Topmed;

use autodie qw(:all);
use Moose;

use Modern::Perl;
use Readonly;
use File::Copy;
use File::Path qw(make_path);
use Path::Class;

with 'CSG::Storage::SlotFS::Roles::Slot';

Readonly::Array my @PATHS => (qw(incoming backup mapping logs run info));

for my $path (@PATHS) {
  has "${path}_path" => (
    is      => 'ro',
    isa     => 'Str',
    lazy    => 1,
    builder => "_build_${path}_path",
  );

  eval "sub _build_${path}_path { return File::Spec->join(shift->path, $path); }";
}

sub initialize {
  my ($self) = @_;

  my @skel_dirs = map {File::Spec->join($self->path, $_)} @PATHS;

  make_path(@skel_dirs, {error => \my $err});

  if (@{$err}) {
    my $errstr;
    for (@{$err}) {
      my ($key, $value) = %{$_};
      $errstr = $value if $key eq '';
    }

    CSG::Storage::Slots::Exceptions::Sample::FailedSkeletonDirectory->throw(error => $errstr);
  }

  return;
}

sub list_paths {
  return join("\n", @PATHS);
}

1;

no Moose;
__PACKAGE__->meta->make_immutable;

1;
