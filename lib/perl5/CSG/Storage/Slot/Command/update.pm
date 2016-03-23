package CSG::Storage::Slot::Command::update;

use CSG::Storage::Slot -command;

use CSG::Storage::Slots;
use CSG::Storage::Slots::Logger;

sub opt_spec {
  return (
    ['name=s',    'Slot name'],
    ['project=s', 'Project name'],
    ['size=s',    'New size for slot'],
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

  unless ($opts->{size}) {
    $self->usage_error('Size is required');
  }
}

sub execute {
  my ($self, $opts, $args) = @_;

  my $rc     = 0;
  my $logger = CSG::Storage::Slots::Logger->new();
  my $slot   = CSG::Storage::Slots->find(name => $opts->{name}, project => $opts->{project});

  if ($slot) {
    $slot->size($opts->{size});
  } else {
    $logger->error('slot not found');
    $rc = 1;
  }

  exit $rc;
}

1;

__END__

=head1

CSG::Storage::Slot::Command::update - Update an existing storage slot size
