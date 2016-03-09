#!/usr/bin/env perl

use local::lib;
use FindBin;
use lib (qq($FindBin::Bin/../t/tests), qq($FindBin::Bin/../lib/perl5));

use Test::CSG::Storage::Sample;

Test::Class->runtests;
