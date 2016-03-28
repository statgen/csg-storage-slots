package CSG::Storage::Slot::Command::list_projects;

use CSG::Storage::Slot -command;
use CSG::Storage::Slots::DB;

use Modern::Perl;

sub execute {
  my ($self, $opts, $args) = @_;

  my $schema = CSG::Storage::Slots::DB->new();
  for my $project ($schema->resultset('Project')->all()) {
    say 'Name: ' . $project->name;
  }
}

1;

__END__

=head1

CSG::Storage::Slot::Command::list_projects - List all defined projects
