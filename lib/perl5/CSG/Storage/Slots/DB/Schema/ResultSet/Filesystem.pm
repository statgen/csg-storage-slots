package CSG::Storage::Slots::DB::Schema::ResultSet::Filesystem;

use base qw(DBIx::Class::ResultSet);

sub next_available {
  return shift->search(
    {},
    {
      order_by => 'rand()',
      limit    => 1
    }
  )->first;
}

1;
