requires 'local::lib';
requires 'Modern::Perl';
requires 'Moose';

on 'test' => sub {
  requires 'Test::Class';
  requires 'Test::More';
};
