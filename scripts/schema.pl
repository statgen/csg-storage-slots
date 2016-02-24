#!/usr/bin/env perl

use FindBin qw($Bin);
use lib qq($Bin/../lib/perl5);
use DBIx::Class::Schema::Loader qw(make_schema_at);

make_schema_at(
  'CSG::Storage::Slots::DB::Schema', {
    debug          => 1,
    dump_directory => qq($Bin/../lib/perl5),
    components     => [qw(InflateColumn::DateTime CSG::CreatedAt)],
  },
  [
    qq{dbi:mysql:database=$ENV{SLOTS_DB};host=$ENV{SLOTS_DB_HOST};port=3306},
    $ENV{SLOTS_DB_USER},
    $ENV{SLOTS_DB_PASS},
  ]
);
