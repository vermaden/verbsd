#! /usr/bin/env perl
use strict;

my $passwd=$ARGV[0];

print "passwords up to 8 characters length: ";
print crypt($passwd,$passwd) . "\n";
