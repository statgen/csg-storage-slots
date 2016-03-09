package Test::CSG::Storage::Sample;

use base qw(Test::Class);
use Test::More;
use Test::Exception;

use FindBin;
use Modern::Perl;
use YAML qw(LoadFile);
use File::Temp;

use CSG::Storage::Sample;

sub class {
  return 'CSG::Storage::Sample';
}

sub startup : Test(startup => 2) {
  my ($self) = @_;

  my $fixtures = LoadFile(qq{$FindBin::Bin/../t/fixtures/samples.yml});

  for my $fixture (@{$fixtures}) {
    my $filename = File::Spec->join(File::Temp->newdir(), $fixture->{filename});

    # TODO - write random length data to $filename
    #      - record size of $filename

    my $sample = $self->class->new(
      filename  => $filename,
      sample_id => $fixture->{sample_id},
      project   => $fixture->{project},
      prefix    => '/net',
    );

    isa_ok($sample, $self->class);
  }

}

sub test_allocate_size : Test(no_plan) {
}

sub test_stage : Test(no_plan) {
}

1;
