package CSG::Storage::SlotFS::Command::init;

use CSG::Storage::SlotFS -command;

sub opt_spec {
  return (
    ['project|p=s', 'Project name the slot belongs to', {required => 1}],
    ['name|n=s',    'Name of the slot to initialize',   {required => 1}],
  );
}

sub validate_args {
  my ($self, $opts, $args) = @_;
}

sub execute {
  my ($self, $opts, $args) = @_;
}

1;

__END__

=head1

CSG::Storage::SlotFS::Command::init - Initialize slot directory structure
