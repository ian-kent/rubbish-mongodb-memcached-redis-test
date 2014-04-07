#!/usr/bin/env perl

use Mango; 
use TestTimer;
use strict;

my $mango = Mango->new('mongodb://localhost:27017');

my $iters = $ARGV[0] // 10000;

$mango->db('test')->collection('test')->remove;
$mango->db('test')->collection('test')->insert({foo => 0});
my ($interval, undef) = TestTimer::time(sub{
  for(my $i = 0; $i < $iters; $i++) {
    $mango->db('test')->collection('test')->find_and_modify({
      query => {},
      update => { '$inc' => { 'foo' => 1 } },
    });
  }
});

my $doc = $mango->db('test')->collection('test')->find_one({});
if($doc->{foo} == $iters) {
  print "Successfully completed in ${interval}s\n";
} else {
  print "Failed in ${interval}s\n";
}


