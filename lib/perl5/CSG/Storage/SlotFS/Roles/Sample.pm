package CSG::Storage::SlotFS::Roles::Sample;

use autodie qw(:all);
use Moose::Role;

use Modern::Perl;
use IPC::System::Simple qw(capture);

use CSG::Storage::Types;

has 'filename'  => (is => 'ro', isa => 'ValidFile', required => 1);
has 'sample_id' => (is => 'ro', isa => 'Str',       lazy     => 1, builder => '_build_sample_id');

sub _build_sample_id {
  return capture(sprintf q{samtools view -H %s|grep '^@RG'|grep -o 'SM:\S*'|sort -u|cut -d \: -f 2}, shift->filename);
}

1;
