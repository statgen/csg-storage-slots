package CSG::Storage::Sample;

use autodie qw(:all);
use Modern::Perl;
use Moose;
use File::Spec;
use overload '""' => sub {shift->to_string};

use CSG::Storage::Slots;
use CSG::Storage::Types;

our $VERSION = '0.1';

has 'filename'  => (is => 'ro', isa => 'ValidFile',       required => 1);
has 'sample_id' => (is => 'ro', isa => 'Str',             required => 1);
has 'project'   => (is => 'ro', isa => 'Str',             required => 1);
has 'prefix'    => (is => 'ro', isa => 'ValidPrefixPath', default  => sub {'/net'});
has 'factor'    => (is => 'ro', isa => 'Int',             default  => sub {4});
has 'size'      => (is => 'ro', isa => 'Int',             lazy     => 1, builder => '_build_size');
has 'path'      => (is => 'ro', isa => 'Str',             lazy     => 1, builder => '_build_path');

sub _build_size {
  my ($self) = @_;
  return (stat($self->filename))[7] * $self->factor;
}

sub _build_path {
  my ($self) = @_;

  my $slot = CSG::Storage::Slots->find_or_create(
    name    => $self->sample_id,
    size    => $self->size,
    project => $self->project,
  );

  return File::Spec->join($self->prefix, $slot->path);
}

sub to_string {
  return shift->path;
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

 CSG::Storage::Sample

=head1 VERSION

This documentation refers to CSG::Storage::Slots version 0.1

=head1 SYNOPSIS

    use CSG::Storage::Sample;

    my $sample = CSG::Storage::Sample->new(
      filename  => '/full/path/to/sample.bam',
      sample_id => 'NWD123456',
      project   => 'topmed',
    );

    # Where does this sample live
    say $sample->path();

=head1 DESCRIPTION



=head1 DIAGNOSTICS



=head1 CONFIGURATION AND ENVIRONMENT



=head1 DEPENDENCIES



=head1 INCOMPATIBILITIES



=head1 BUGS AND LIMITATIONS

There are no known bugs in this module.
Please report problems to Chris Scheller <schelcj@umich.edu>
Patches are welcome.

=head1 AUTHOR

Chris Scheller <schelcj@umich.edu>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2016 Regents of the University of Michigan. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty
