#!/usr/bin/env perl

use Redis;
use TestTimer;
use strict;

my $redis = Redis->new( server => '127.0.0.1:6379' );

my $iters = $ARGV[0] // 10000;

$redis->set("foo" => 0);
my ($interval, undef) = TestTimer::time(sub{
  for(my $i = 0; $i < $iters; $i++) {
    $redis->incr("foo");
  }
});

if($redis->get("foo") == $iters) {
  print "Successfully completed in ${interval}s\n";
} else {
  print "Failed in ${interval}s\n";
}


