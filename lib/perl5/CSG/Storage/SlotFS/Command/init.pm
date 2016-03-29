package CSG::Storage::SlotFS::Command::init;

use CSG::Storage::SlotFS -command;

use Modern::Perl;
use Module::Load;

use CSG::Logger;

sub opt_spec {
  return (
    ['project|p=s',  'Project name the slot belongs to',  {required => 1}],
    ['name|n=s',     'Name of the slot to initialize',    {required => 1}],
    ['filename|f=s', 'Full path to sample (bam or cram)', {required => 1}],
  );
}

sub execute {
  my ($self, $opts, $args) = @_;

  my $rc     = 0;
  my $logger = CSG::Logger->new();
  my $class  = 'CSG::Storage::SlotFS::' . ucfirst(lc($opts->{project}));
  my $topmed = undef;

  try {
    load $class;

    $topmed = $class->new(
      project  => $opts->{project},
      name     => $opts->{name},
      filename => $opts->{filename},
    );

    $topmed->initialize;
  }
  catch {
    if (not ref $_) {
      $logger->error($_);
    } elsif ($_->isa('CSG::Storage::Slots::Exceptions::Sample::FailedSkeletonDirectory')) {
      $logger->error($_->error);
    } else {
      if ($_->isa('Exception::Class')) {
        $logger->error($_->error);
      } else {
        $logger->error("something went sideways: $_");
      }
    }

    $rc = 1;
  }
  finally {
    unless (@_) {
      say $logger->info($topmed->path);
    }
  };

  exit $rc;
}

1;

__END__

=head1

CSG::Storage::SlotFS::Command::init - Initialize slot directory structure
