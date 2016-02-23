package CSG::Storage::Slots::DB;

use base qw(CSG::Storage::Slots::DB::Schema);

sub new {
  return __PACKAGE__->connect(
    qq{dbi:mysql:database=$ENV{SLOTS_DB};host=$ENV{SLOTS_DB_HOST};port=3306},
    $ENV{SLOTS_DB_USER},
    $ENV{SLOTS_DB_PASS}
  );
}

1;
