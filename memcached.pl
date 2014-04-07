#!/usr/bin/env perl

use Cache::Memcached;
use TestTimer;
use strict;

my $memd = Cache::Memcached->new({
  'servers' => [ "127.0.0.1:11211" ],
});

my $iters = $ARGV[0] // 10000;

$memd->set("foo" => 0);
my ($interval, undef) = TestTimer::time(sub{
  for(my $i = 0; $i < $iters; $i++) {
    $memd->incr("foo");
  }
});

if($memd->get("foo") == $iters) {
  print "Successfully completed in ${interval}s\n";
} else {
  print "Failed in ${interval}s\n";
}


