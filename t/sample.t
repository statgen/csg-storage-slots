#!/usr/bin/env perl

use FindBin qw($Bin);
use lib (qq($Bin/../local/lib/perl5), qq($Bin/../t/tests), qq($Bin/../lib/perl5));

use Test::CSG::Storage::Sample;
Test::Class->runtests;
