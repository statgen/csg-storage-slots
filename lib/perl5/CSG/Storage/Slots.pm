package CSG::Storage::Slots;

use Modern::Perl;
use Moose;
use File::Spec;
use URI;
use Digest::SHA qw(sha1_hex);
use overload '""' => sub {shift->to_string};

use CSG::Storage::Slots::DB;
use CSG::Storage::Slots::Exceptions;
use CSG::Storage::Slots::Types;

our $VERSION = "0.1";

has 'name'    => (is => 'ro', isa => 'Str',           required => 1);
has 'project' => (is => 'ro', isa => 'ValidProject',  required => 1);
has 'size'    => (is => 'ro', isa => 'ValidSlotSize', required => 1);

has 'sha1' => (is => 'ro', isa => 'Str', lazy => 1, builder => '_build_sha1');
has 'path' => (is => 'ro', isa => 'URI', lazy => 1, builder => '_build_path');

has '_record' => (is => 'rw', isa => __PACKAGE__ . '::DB::Schema::Result::Slot', predicate => 'has_record');

around [qw(name project size path)] => sub {
  my $orig = shift;
  my $self = shift;

  unless ($self->has_record) {
    my $schema = CSG::Storage::Slots::DB->new();
    my $fs     = $schema->resultset('Filesystem')->next_available($self->{project});
    my $record = $schema->resultset('Slot')->find_or_create(
      {
        name          => $self->{name},
        size          => $self->{size},
        filesystem_id => $fs->id,
      }
    );

    $self->_record($record);
  }

  return $self->$orig(@_);
};

sub _build_sha1 {
  return sha1_hex(shift->name);
}

sub _build_path {
  my ($self) = @_;

  my $hostname = $self->_record->filesystem->hostname;
  my $fs_path  = $self->_record->filesystem->path;
  my $path     = File::Spec->join($hostname, $fs_path, (split(//, $self->sha1))[0 .. 3], $self->name);

  return URI->new($path);
}

sub to_string {
  return shift->path->as_string;
}

sub find {
  my $class  = shift;
  my %params = @_;
  my $schema = CSG::Storage::Slots::DB->new();
  my $slot   = $schema->resultset('Slot')->search(
    {
      'me.name'      => $params{name},
      'project.name' => $params{project},
    }, {
      join => {filesystem => 'project'},
    }
  )->first;

  return unless $slot;

  return $class->new(
    name    => $slot->name,
    project => $slot->filesystem->project->name,
    size    => $slot->size,
    _record => $slot,
  );
}

sub find_or_create {
  my $class = shift;
  return $class->find(@_) // $class->new(@_);
}

no Moose;
__PACKAGE__->meta->make_immutable;

1;

__END__

=head1 NAME

 CSG::Storage::Slots

=head1 VERSION

This documentation refers to CSG::Storage::Slots version 0.1

=head1 SYNOPSIS

    use CSG::Storage::Slots;

    my $slot = CSG::Storage::Slots->new(name => 'foo', project => 'bar', size => '200G');

    say $slot->path;

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
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
