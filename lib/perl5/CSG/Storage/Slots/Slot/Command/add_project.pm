package CSG::Storage::Slots::Slot::Command::add_project;

use CSG::Storage::Slots::Slot -command;
use CSG::Storage::Slots::DB;
use CSG::Storage::Slots::Logger;

sub opt_spec {
  return (['name=s', 'Project name', {required => 1}],);
}

sub validate_args {
  my ($self, $opts, $args) = @_;

  my $schema = CSG::Storage::Slots::DB->new();
  if ($schema->resultset('Project')->find({name => $opts->{project}})) {
    $self->usage_error('project already exists');
  }
}

sub execute {
  my ($self, $opts, $args) = @_;

  my $schema = CSG::Storage::Slots::DB->new();
  $schema->resultset('Project')->create({name => $opts->{name}});
  exit 1;
}

1;

__END__

=head1

CSG::Storage::Slots::Slot::Command::add_project - Add a new project