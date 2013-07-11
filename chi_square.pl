use v5.14;
use strict;
use warnings;
use Statistics::ChisqIndep;

my $data = [ [350, 1000], [300, 1000] ];
my $significance = 95;

my $chi = Statistics::ChisqIndep->new;
$chi->load_data($data);

my $prob = sprintf("%2.4f", (1 - $chi->{p_value}) * 100);
say $prob > $significance ? 'significant' : 'not significant';
say $prob , '%';
