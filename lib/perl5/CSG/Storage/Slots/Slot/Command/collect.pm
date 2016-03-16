package CSG::Storage::Slots::Slot::Command::collect;

use CSG::Storage::Slots::Slot -command;

sub opt_spec {
  return ();
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

CSG::Storage::Slots::Slot::Command::collect - Collect disk usage info for a slot storage filesystem
