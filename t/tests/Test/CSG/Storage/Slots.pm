package Test::CSG::Storage::Slots;

use base qw(Test::CSG::Storage::Base);
use Test::More;
use Test::Exception;

use Modern::Perl;
use Digest::SHA qw(sha1_hex);

use CSG::Storage::Slots;
use CSG::Storage::Slots::DB;

sub class {
  return 'CSG::Storage::Slots';
}

sub test_new : Test(5) {
  my ($self) = @_;

  throws_ok {$self->class->new()} 'Moose::Exception::AttributeIsRequired', 'missing all params for new()';
  throws_ok {$self->class->new(name => 'foobar')} 'Moose::Exception::AttributeIsRequired', 'missing project and size for new()';
  throws_ok {$self->class->new(name => 'foobar', project => 'proj1')} 'Moose::Exception::AttributeIsRequired',
    'missing size for new()';

  lives_ok {$self->class->new(name => 'foobar', project => 'proj1', size => '100T')} 'all params given for new()';

  throws_ok {$self->class->new(name => 'foo', project => 'foo', size => '100T')}
  'Moose::Exception::ValidationFailedForInlineTypeConstraint', 'invalid project name';
}

sub test_path : Test(2) {
  my ($self) = @_;

  my $slot = $self->class->new(
    name    => 'foobar',
    project => 'proj1',
    size    => '300GB',
  );

  like($slot->to_string, qr{^foo[1|2]\.localhost/working/slots[1|2]/8/8/4/3/foo}, 'to_string() path matches');
  like("$slot", qr{^foo[1|2]\.localhost/working/slots[1|2]/8/8/4/3/foo}, 'stringification path matches');
}

sub test_sha1 : Test(1) {
  my ($self) = @_;
  my $name   = 'foobarbaz';
  my $slot   = $self->class->new(name => $name, project => 'proj1', size => '200GB');

  is($slot->sha1, sha1_hex($name), 'SHA1 should match');
}

1;
