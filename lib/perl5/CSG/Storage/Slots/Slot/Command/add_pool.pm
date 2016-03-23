package CSG::Storage::Slots::Slot::Command::add_pool;

use CSG::Storage::Slots::Slot -command;
use CSG::Storage::Slots::DB;
use CSG::Storage::Slots::Logger;

use File::Spec;
use Filesys::DiskUsage qw(du);
use Number::Bytes::Human qw(parse_bytes);

sub opt_spec {
  return (
    ['name=s',     'Descriptive name for the pool',                                       {required => 1}],
    ['hostname=s', 'Hostname that the pool resides on (for nfs based pools)',             {required => 1}],
    ['path=s',     'Path where slots will be stored',                                     {required => 1}],
    ['size=s',     'Total space available for slots in human readable form (i.e. 400Tb)', {required => 1}],
    ['project=s',  'Project this this pool belongs to',                                   {required => 1}],
  );
}

sub validate_args {
  my ($self, $opts, $args) = @_;

  my $schema = CSG::Storage::Slots::DB->new();
  unless ($schema->resultset('Project')->find({name => $opts->{project}})) {
    $self->usage_error('project does not exist');
  }

  if ($schema->resultset('Pool')->find({name => $opts->{name}})) {
    $self->usage_error('pool already exists');
  }
}

sub execute {
  my ($self, $opts, $args) = @_;

  my $schema  = CSG::Storage::Slots::DB->new();
  my $logger  = CSG::Storage::Slots::Logger->new();
  my $type    = $schema->resultset('Type')->find({name => 'nfs'});                 # XXX - only type right now
  my $project = $schema->resultset('Project')->find({name => $opts->{project}});
  my $pool    = $project->add_to_pools(
    {
      name       => $opts->{name},
      hostname   => $opts->{hostname},
      path       => $opts->{path},
      size_total => parse_bytes($opts->size),
      type_id    => $type->id,
    }
  );
}

1;

__END__

=head1

CSG::Storage::Slots::Slot::Command::add_pool - Add a new pool to server slots
