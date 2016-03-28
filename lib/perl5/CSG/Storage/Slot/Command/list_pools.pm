package CSG::Storage::Slot::Command::list_pools;

use CSG::Storage::Slot -command;
use CSG::Storage::Slots::DB;

use Modern::Perl;

sub execute {
  my ($self, $opts, $args) = @_;

  my $schema = CSG::Storage::Slots::DB->new();

  for my $pool ($schema->resultset('Pool')->all()) {
    say 'Name: ' . $pool->name;
    say "\tProject: " . $pool->project->name;
    say "\tHostname: " . $pool->hostname;
    say "\tPath: " . $pool->path;
    say "\tSpace Total: " . $pool->size_total;
    say "\tSpace Used: " . $pool->size_used;
    say '';
  }
}

1;

__END__

=head1

CSG::Storage::Slot::Command::list_pools - List all defined pools
