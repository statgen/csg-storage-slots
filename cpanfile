requires 'local::lib';
requires 'Modern::Perl';
requires 'Moose';
requires 'URI';
requires 'DBIx::Class::Schema::Loader';
requires 'Exception::Class';
requires 'DateTime';
requires 'DateTime::Format::MySQL';
requires 'Path::Class';

on 'test' => sub {
  requires 'SQL::Translator';
  requires 'YAML';
  requires 'Test::Class';
  requires 'Test::More';
  requires 'Test::Exception';
};
