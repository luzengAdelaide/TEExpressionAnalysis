#!/bin/bash

# Add introns into 6 target species

arr=( 'anolis' 'gal' 'mdo' 'oana' 'hg' 'bg' )
arr2=( 'anolis' 'gal' 'mdo' 'oana' )

for i in "${arr[@]}"
do
    perl gff_to_bed.pl $i > bed_$i.gtf
done


for i in "${arr2[@]}"
do
    echo bed_$i.gtf
    # Reorder the gtf file
    perl prepare_data_intron.pl bed_$i.gtf > bed_$i.gtf.tmp

    # Reverse the array of minus strand from ensemble file
    awk '{if($4=="-") print $0}' bed_$i.gtf.tmp > bed_$i.gtf.tmp_neg
    awk '{if($4=="+") print $0}' bed_$i.gtf.tmp > bed_$i.gtf.tmp_pos
    perl -e 'print reverse <>' bed_$i.gtf.tmp_neg > bed_$i.gtf.tmp_neg.use

    # Add introns between exons based on same transcript id
    cat bed_$i.gtf.tmp_neg.use bed_$i.gtf.tmp_pos > bed_$i.gtf.tmp2
    perl add_intron_hash.pl bed_$i.gtf.tmp2 > bed_$i.gtf.intron
done

rm *.tmp*

# Pogona
perl prepare_data_intron.pl bed_bg.gtf >  bed_bg.gtf.tmp 
sed -i 's/Parent=//g; s/ID=//g' bed_bg.gtf.tmp 
perl add_intron_hash.pl bed_bg.gtf.tmp > bed_bg.gtf.intron

# Human
perl gff_to_bed.pl hg19v37.refgene.gtf > bed_hg.gtf
awk '{print $1 "\t"  $2 "\t" $3 "\t" $4 "\t" $5 "\t" $8 "_" $9 "\t" $6 "_" $7}' bed_hg.gtf > bed_hg.gtf.tmp
perl add_intron_hash.pl bed_hg.gtf > bed_hg.gtf.intron
awk '{if($2<$3) print $0}' bed_hg.gtf.intron > tmp && mv tmp bed_hg.gtf.intron
