package CSG::Storage::Slot::Command::add_type;

use CSG::Storage::Slot -command;

use Modern::Perl;

use CSG::Storage::Slots::DB;

sub opt_spec {
  return (['name|n=s', 'Name for type', {required => 1}],);
}

sub validate_args {
  my ($self, $opts, $args) = @_;
  my $schema = CSG::Storage::Slots::DB->new();

  if ($schema->resultset('Type')->find({name => $opts->{name}})) {
    $self->usage_error('type already exists');
  }
}

sub execute {
  my ($self, $opts, $args) = @_;

  my $schema = CSG::Storage::Slots::DB->new();
  $schema->resultset('Type')->create({name => $opts->{name}});
}

1;
