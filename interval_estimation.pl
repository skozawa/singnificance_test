use v5.14;
use strict;
use warnings;
use Statistics::PointEstimation;

my $data = [ [350, 650], [300, 700] ];
my $significance = $ARGV[0] // 95;

my $a_stats = stats($data->[0]);
my $b_stats = stats($data->[1]);

printf("%2.4f%%\t%2.4f%%\t%2.4f%%\n", $a_stats->lower_clm * 100, $a_stats->mean * 100, $a_stats->upper_clm * 100);
printf("%2.4f%%\t%2.4f%%\t%2.4f%%\n", $b_stats->lower_clm * 100, $b_stats->mean * 100, $b_stats->upper_clm * 100);

say $a_stats->lower_clm > $b_stats->upper_clm ? 'significant' : 'not significant';

sub stats {
    my $data = shift;

    my $total    = $data->[0] + $data->[1];
    my $mean     = $data->[0] / $total;
    my $variance = $mean * ( 1 - $mean );

    my $stats = Statistics::PointEstimation::Sufficient->new;
    $stats->set_significance($significance);
    $stats->load_data($total, $mean, $variance);
    return $stats;
}

# perl interval_estimation.pl 95
# 32.0402%        35.0000%        37.9598%
# 27.1564%        30.0000%        32.8436%
# not significant

# perl interval_estimation.pl 90
# 32.5167%        35.0000%        37.4833%
# 27.6141%        30.0000%        32.3859%
# significant
