requires 'local::lib';
requires 'Modern::Perl';
requires 'Moose';
requires 'URI';
requires 'DBIx::Class::Schema::Loader';
requires 'Exception::Class';
requires 'DateTime';
requires 'DateTime::Format::MySQL';
requires 'Path::Class';
requires 'IPC::System::Simple';
requires 'App::Cmd';
requires 'Log::Dispatch';
requires 'Try::Tiny';

on 'test' => sub {
  requires 'SQL::Translator';
  requires 'YAML';
  requires 'File::Stat';

  requires 'Test::Class';
  requires 'Test::More';
  requires 'Test::Exception';
};
