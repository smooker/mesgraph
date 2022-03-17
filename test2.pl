#!/usr/bin/perl -w
#
# A mixed stock graph

use strict;
use GD;
use GD::Graph::Data;
use GD::Graph::mixed;

# Read in the data from a file

my $file = "start4.csv";

open FILE, "<$file";
open FILE2, ">$file"."_ok";
my $cnt = 0;

my @names;
my @units;
my @legend;

while (<FILE>) {
#    chomp $_;
    $cnt++;
    if ($cnt == 2) {
#        m/(\S+)\t(\S+)\t(\S+)\t(\S+)/;
#        $units[0] = $1;
#        $units[1] = $2;
#        $units[2] = $3;
#        $units[3] = $4;
        @units = split("\t", $_);
        next;
    }
#ef bb bf in front
    if ($cnt == 1) {
#        m/\x{ef}\x{bb}\x{bf}(\S+)\t(\S+)\t(\S+)/;
#        $names[0] = $1;
#        $names[1] = $2;
#        $names[2] = $3;
#        $names[3] = $4;
        @names = split("\t", $_);
        next;
    }
    print FILE2;
}
close FILE2;
close FILE;

$cnt = 0;

print @names."\n";
foreach ( @names ) {
    print $_."\t";
}
print "\n";
print @units."\n";
foreach ( @units ) {
    chomp $names[$cnt];
    chomp $units[$cnt];
    $legend[$cnt] = $names[$cnt]."(".$units[$cnt].")";
    $legend[$cnt] =~ s/\"//g;
    print $_."\t";
    $cnt++;
}
print "\n";

my $data = GD::Graph::Data->new( );
$data->read(file => $file."_ok");

my $graph = new GD::Graph::mixed(1800, 1000) or die "Can't create graph!";

# Set the general attributes

$graph->set(
        title             => "2.8 JTD nepalene",
        transparent       => 0,
);
#        dclrs             => [qw(red green blue yellow)],
#        types             => [qw(lines lines lines lines)],

# Set the attributes for the x-axis

$graph->set(
        x_label           => $legend[0],
        x_label_skip      => 5,
        x_labels_vertical => 1,
);

@legend = @legend[ 1 .. $#legend ];

$graph->set(
        y_max_value       => ($data->get_min_max_y_all( ))[1]+25,
        y_tick_number     => 1,
        y_all_ticks       => 0,
        y_number_format   => sub { ''.int(shift); },
);

# Set the legend

#$graph->set_legend('test1', 'test2', 'test3', 'test4');
#$graph->set_legend($names[0], $names[0], $names[0], $names[0]);
$graph->set_legend(@legend);
$graph->set_legend_font(gdLargeFont);
$graph->set(legend_placement => 'BL');

# Plot the data

my $gd = $graph->plot( $data ) or die "Can't plot graph";

open OUT, ">cheese.png" or die "Couldn't open for output: $!";
binmode(OUT);
print OUT $gd->png( );
close OUT;

