#!/bin/bash
#sed 's/[\x80-\xff]//g'
#ef bb bf in front

# example ./go.sh ./SLED_PODMIANA/it.csv


iconv -f UTF-16LE -t UTF-8 $1 |sed 's/\r$//' | sed 's/\xef\xbb\xbf//g' | cut -f1-5 > start4.csv
./test2.pl
feh cheese.png
