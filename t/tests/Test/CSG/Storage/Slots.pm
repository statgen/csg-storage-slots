package Test::CSG::Storage::Slots;

use base qw(Test::Class);
use Test::More;

use CSG::Storage::Slots;

sub class {
  return 'CSG::Storage::Slots';
}

sub startup : Test(startup) {

  # TODO - create test database
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

sub shutdown : Test(shutdown) {

  # TODO - drop test database
}

sub test_path : Test(1) {
  my ($self) = @_;
  my $slot   = $self->{stash}->{slot};

  is($slot->to_string, '/tmp/foo', 'path matches');
}

# TODO - test to write
#   * new - with valid/invalid projects/sizes/names and duplicates
#   * path - path returns expected uri
#   * to_string - return valid and expected path
#   * stringification overload thingus
#

1;
