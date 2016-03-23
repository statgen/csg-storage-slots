package CSG::Storage::Slot::Command::new;

use CSG::Storage::Slot -command;

use Modern::Perl;
use Try::Tiny;

use CSG::Storage::Sample;
use CSG::Logger;

sub opt_spec {
  return (
    ['name=s',    'Name for the slot'],
    ['file=s',    'File to store in the slots incoming directory'],
    ['project=s', 'Project name for slot filesystems'],
    ['prefix=s',  'why do we have this?'],
  );
}

sub validate_args {
  my ($self, $opts, $args) = @_;

  unless ($opts->{name}) {
    $self->usage_error('Name is required');
  }

  unless ($opts->{file}) {
    $self->usage_error('File is required');
  }

  unless ($opts->{project}) {
    $self->usage_error('Project name is required');
  }

  unless ($opts->{prefix}) {
    $self->usage_error('Prefix is required...for now');
  }
}

sub execute {
  my ($self, $opts, $args) = @_;

  my $logger = CSG::Logger->new();
  my $rc     = 0;
  my $sample = undef;

  try {
    $sample = CSG::Storage::Sample->new(
      sample_id => $opts->{name},
      filename  => $opts->{file},
      project   => $opts->{project},
      prefix    => $opts->{prefix},
    );

    $sample->stage();
  }
  catch {
    if (not ref $_) {
      $logger->error($_);
    } elsif ($_->isa('CSG::Storage::Slots::Exceptions::Sample::FailedSkeletonDirectory')) {
      $logger->error($_->error);
    } elsif ($_->isa('CSG::Storage::Slots::Exceptions::Sample::FailedCopy')) {
      $logger->error($_->error);
    } else {
      if ($_->isa('Exception::Class')) {
        $logger->error($_->error);
      } else {
        $logger->error("something went sideways: $_");
      }
    }

    $rc = 1;
  } finally {
    unless (@_) {
      $logger->info($sample->path);
    }
  };

  exit $rc;
}

1;

__END__

=head1

CSG::Storage::Slot::Command::new - Create a new storage slot
