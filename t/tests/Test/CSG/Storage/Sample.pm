package Test::CSG::Storage::Sample;

use base qw(Test::CSG::Storage::Base);
use Test::More;

use Modern::Perl;
use File::Stat;
use YAML qw(LoadFile);

use CSG::Storage::Sample;

sub class {
  return 'CSG::Storage::Sample';
}

sub startup : Test(startup => 2) {
  my ($self) = @_;

  my $fixtures = LoadFile(File::Spec->join($self->fixture_path, 'samples.yml'));

  for my $fixture (@{$fixtures}) {
    my $sample = $self->class->new(
      filename  => File::Spec->join($self->fixture_path, 'samples', $fixture->{filename}),
      sample_id => $fixture->{sample_id},
      project   => $fixture->{project},
      prefix    => $self->prefix,
    );

    isa_ok($sample, $self->class);
    diag $sample->path;

    push @{$self->{stash}->{samples}}, $sample;
  }
}

sub test_path : Test(no_plan) {
  local $TODO = 'Implement tests';
}

1;
