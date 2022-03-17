#!/usr/bin/perl
use Chart::Gnuplot;
 
# Data
my @x = (-10 .. 10);
my @y = (0 .. 20);
 
# Create chart object and specify the properties of the chart
my $chart = Chart::Gnuplot->new(
    output => "simple.png",
    title  => "Simple testing",
    xlabel => "My x-axis label",
    ylabel => "My y-axis label",
);
 
#./SLED_PODMIANA/start1.csv

## Create dataset object and specify the properties of the dataset
my $dataSet = Chart::Gnuplot::DataSet->new(
    xdata => \@x,
    ydata => \@y,
    title => "Plotting a line from Perl arrays",
    style => "linespoints",
);
 
# Plot the data set on the chart
$chart->plot2d($dataSet);
 
##################################################
 
# Plot many data sets on a single chart
#$chart->plot2d($dataSet1, $dataSet2, ...);
