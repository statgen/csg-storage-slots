package Test::CSG::Storage::Slots;

use base qw(Test::Class);
use Test::More;

use CSG::Storage::Slots;

sub class {
  return 'CSG::Storage::Slots';
}

sub startup : Test(startup) {

  # TODO - create sqlite database file
}

sub setup : Test(setup) {

  # TODO - load fixture data into db
}

sub teardown : Test(teardown) {

  # TODO - purge database records
}

sub shutdown : Test(shutdown) {

  # TODO - delete sqlite database file
}

sub test_new : Test(no_plan) {
  my ($self) = @_;

  my $slot = $self->class->new(
    name    => 'foo',
    project => 'topmed',
    size    => '300GB',
  );

  isa_ok($slot, $self->class);
}

# TODO - test to write
#   * new - with valid/invalid projects/sizes/names and duplicates
#   * path - path returns expected uri
#   * to_string - return valid and expected path
#   * stringification overload thingus
#

1;
