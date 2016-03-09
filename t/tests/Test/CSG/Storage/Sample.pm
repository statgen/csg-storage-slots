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

sub test_allocate_size : Test(no_plan) {
  my ($self) = @_;

}

sub test_stage : Test(16) {
  my ($self) = @_;

  for my $sample (@{$self->{stash}->{samples}}) {
    $sample->stage();

    ok(-e File::Spec->join($sample->path, 'incoming'), 'Skeleton incoming directory was created');
    ok(-e File::Spec->join($sample->path, 'backup'),   'Skeleton backup directory was created');
    ok(-e File::Spec->join($sample->path, 'mapping'),  'Skeleton mapping directory was created');
    ok(-e File::Spec->join($sample->path, 'logs'),     'Skeleton logs directory was created');
    ok(-e File::Spec->join($sample->path, 'run'),      'Skeleton run directory was created');
    ok(-e File::Spec->join($sample->path, 'info'),     'Skeleton info directory was created');
    ok(-e $sample->incoming_path, 'Sample exists in incoming directory');

    my $sample_stat   = File::Stat->new($sample->filename);
    my $incoming_stat = File::Stat->new($sample->incoming_path);

    is($sample_stat->size, $incoming_stat->size, 'original sample and copy in incoming match');
  }
}

1;
