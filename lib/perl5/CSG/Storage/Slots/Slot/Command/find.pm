package CSG::Storage::Slots::Slot::Command::find;

use CSG::Storage::Slots::Slot -command;

use CSG::Storage::Slots;
use CSG::Storage::Slots::Logger;

sub opt_spec {
  return (
    ['name=s',    'Slot name'],
    ['project=s', 'Project name'],
  );
}

sub validate_args {
  my ($self, $opts, $args) = @_;

  unless ($opts->{name}) {
    $self->usage_error('Name is required');
  }

  unless ($opts->{project}) {
    $self->usage_error('Project name is required');
  }
}

sub execute {
  my ($self, $opts, $args) = @_;

  my $rc     = 0;
  my $logger = CSG::Storage::Slots::Logger->new();
  my $slot   = CSG::Storage::Slots->find(name => $opts->{name}, project => $opts->{project});

  if ($slot) {
    $logger->info($slot->to_string);
  } else {
    $logger->error('slot not found');
    $rc = 1;
  }

  exit $rc;
}

1;

__END__

=head1

CSG::Storage::Slots::Slot::Command::find - Find an existing storage slot path
