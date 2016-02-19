requires 'local::lib';
requires 'Modern::Perl';
requires 'Moose';
requires 'URI';

on 'test' => sub {
  requires 'Test::Class';
  requires 'Test::More';
};
