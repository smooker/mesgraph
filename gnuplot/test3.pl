#!/usr/bin/perl

# {{{ ->create graph method
#
sub create_graph {
    my $class = shift;

    open my $plot => "| /usr/bin/gnuplot"
        or die "Failed to open pipe: $!\n";

    my $outfile = "./graph.png";
    print $plot <<"--";
    print GPVAL_TERMINALS

    set  terminal png
    set  out "$outfile"
    set  format x "/%b%y/"
    set  xdata  time
    set  key left top Left reverse samplen 2 title "Legend" box

    set  timefmt "%s:"

    set  grid   xtics ytics
    set  xtics  nomirror
    set  ytics  nomirror
    set  y2tics nomirror

    set  autoscale

    set  ylabel "ResponseTime"
    plot "$class" using 1:2 smooth unique axis x1y1 title "Time in ms"
--
    #set   timefmt "%Y-%m-%d:"
    close $plot or die "Failed to close pipe: $!\n";
    chmod 0644 => $outfile or die "Failed to chmod $outfile: $!\n";

} # }}}

create_graph("./start4.csv_ok");
