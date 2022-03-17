    print GPVAL_TERMINALS

    set  terminal png
    set  out "graph.png"
    set  multiplot

    set  format x "/%b%y/"
    set  xdata  time
    set  key left top Left reverse samplen 2 title "Legend" box

    set  timefmt "%s:"

    set  grid   xtics ytics
    set  xtics  nomirror
    set  ytics  nomirror

    set  y2tics nomirror
    set  y2range[0:*]

#    set  autoscale

    set  ylabel "ResponseTime1"
    set  y2label "ResponseTime2"

    stats 'start4.csv_ok' index 1 using 2 prefix "A"
    set xdata time
    set arrow 1 from A_index_min, graph 0.1 to A_index_min, A_min fill
    set arrow 2 from A_index_max, graph 0.9 to A_index_max, A_max fill

    plot "start4.csv_ok" using 1:2 smooth unique axis x1y1 title "Time in ms",