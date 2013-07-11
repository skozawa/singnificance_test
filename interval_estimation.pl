use v5.14;
use strict;
use warnings;
use List::Util qw(sum);
use Statistics::PointEstimation;

my $data = [ [350, 650], [300, 700] ];
my $significance = 95;

my $a_stats = stats($data->[0]);
my $b_stats = stats($data->[1]);

say $a_stats->lower_clm, "\t", $a_stats->upper_clm;
say $b_stats->lower_clm, "\t", $b_stats->upper_clm;

say $a_stats->lower_clm > $b_stats->upper_clm ? 'significant' : 'not significant';

sub stats {
    my $data = shift;

    my $total    = sum @$data;
    my $mean     = $data->[0] / $total;
    my $variance = $mean * ( 1 - $mean );

    my $stats = Statistics::PointEstimation::Sufficient->new;
    $stats->set_significance($significance);
    $stats->load_data($total, $mean, $variance);
    return $stats;
}
