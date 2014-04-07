package TestTimer;

use Time::HiRes qw/ gettimeofday tv_interval /;

sub time {
  my ($sub) = @_;
  my $start = [gettimeofday];
  my $output = $sub->();
  my $end = [gettimeofday];
  my $interval = tv_interval($start, $end);
  return ($interval, $output);
}

1;
