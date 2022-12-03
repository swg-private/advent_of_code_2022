#!/usr/bin/env perl

use strict;
use warnings;
use List::Util qw(sum);

open my $fh, '<', 'input.txt' or die;
local $/ = undef;
my $contents = <$fh>;
close $fh;

my @elves = sort { $b <=> $a }
  map { sum @{$_} } 
  map { [ split /\n/, $_ ] } 
  split /\n\n/, $contents;

print "The maximum calories are $elves[0]!\n";
print "The top 3 elves carry " . ( sum @elves[0..2] ) . " calories!\n";
