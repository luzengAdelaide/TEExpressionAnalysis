#!/bin/bash

arr=( 'anolis' 'gal' 'mdo' 'oana' 'bg' 'hg' )
arr2=( 'cds' 'intron' 'utr3' 'utr5' 'upstream_1kb' 'downstream_1kb' )

for i in "${arr[@]}"
do
    for j in "${arr2[@]}"
    do
	echo overlap_$i\_$j > test.txt
	echo $j\_$i > count.txt
	awk '{len+=$3-$2+1}{print len}' overlap_$i\_$j|tail -1 > test2.txt
	awk '{len+=$3-$2+1}{print len}' $j\_$i|tail -1 > count2.txt
	paste test.txt count.txt test2.txt count2.txt >> overlap_content.txt
    done
done
rm test*.txt
rm count*.txt

awk '{prop=$3/$4*100}{print $1 "\t" $2 "\t" $3 "\t" $4 "\t" prop}' overlap_content.txt > prop_overlap_repeat
