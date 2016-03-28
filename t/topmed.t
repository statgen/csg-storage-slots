#!/usr/bin/env perl

use FindBin qw($Bin);
use local::lib qq($Bin/../local);
use lib (qq($Bin/../t/tests), qq($Bin/../lib/perl5));

use Test::CSG::Storage::SlotFS::Topmed;
Test::Class->runtests;
