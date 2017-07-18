#!/bin/bash

# Get the overlap between repeats and different gene compartments
cd /data/rc003/lu/transcriptome/gene_expression_all/repeats_overlaps_genome/test
arr=( 'anolis' 'gal' 'mdo' 'oana' )

# Extract gene compartments
for i in "${arr[@]}"
do
    echo bed_$i.gtf 
    grep 'three' bed_$i.gtf >  utr3_$i
    grep 'five' bed_$i.gtf > utr5_$i
    grep 'CDS' bed_$i.gtf > cds_$i
    grep 'intron' bed_$i.gtf.intron > intron_$i
done

# Used BEDTools to get the overlap between two datasets
for i in "${arr[@]}"
do
    echo $i
    intersectBed -a utr3_$i -b ../bed_$i\_combine.map > overlap_$i\_utr3
    intersectBed -a utr5_$i -b ../bed_$i\_combine.map > overlap_$i\_utr5
    intersectBed -a cds_$i -b ../bed_$i\_combine.map > overlap_$i\_cds
    intersectBed -a intron_$i -b ../bed_$i\_combine.map > overlap_$i\_intron
done


# The pogona genome annotation was from private source
# Pogona
grep 'UTR3' bed_bg.gtf > utr3_bg
grep 'UTR5' bed_bg.gtf > utr5_bg
# As I changed the CDS to exon in pogona annotation
grep 'exon' bed_bg.gtf > cds_bg
grep 'intron' bed_bg.gtf.intron > intron_bg
intersectBed -a utr3_bg -b ../bed_bg_combine.map > overlap_bg_utr3
intersectBed -a utr5_bg -b ../bed_bg_combine.map > overlap_bg_utr5
intersectBed -a cds_bg -b ../bed_bg_combine.map > overlap_bg_cds
intersectBed -a intron_bg -b ../bed_bg_combine.map > overlap_bg_intron


# The human 3'UTR, 5'UTR, upstream 1kb and downstream 1kb was downloaded from UCSC
# Human
grep 'CDS' bed_hg.gtf > cds_hg
grep 'intron' bed_hg.gtf.intron > intron_hg
intersectBed -a cds_hg -b ../bed_hg_combine.map > overlap_hg_cds
intersectBed -a intron_hg -b ../bed_hg_combine.map > overlap_hg_intron
intersectBed -a Gene_regions/utr3_exon_hg -b ../bed_hg_combine.map > overlap_hg_utr3_exon
intersectBed -a Gene_regions/utr5_exon_hg -b ../bed_hg_combine.map > overlap_hg_utr5_exon
intersectBed -a Gene_regions/upstream_1kb_hg -b ../bed_hg_combine.map > overlap_hg_upstream
intersectBed -a Gene_regions/downstream_1kb_hg -b ../bed_hg_combine.map > overlap_hg_downstream
