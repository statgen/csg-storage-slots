package CSG::Storage::Slots::DB::Schema::ResultSet::Filesystem;

use base qw(DBIx::Class::ResultSet);

sub next_available {
  my ($self, $project, $size) = @_;
  return $self->search(
    {
      'project.name' => $project
    },
    {
      join     => 'project',
      order_by => 'rand()',
      limit    => 1
    }
  )->first;
}

1;
