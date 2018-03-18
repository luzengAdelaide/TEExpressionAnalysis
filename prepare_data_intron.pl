#!/bin/perl -w
use strict;

# Prepare the data for add intron
my ($file)=@ARGV;
open(IN,"$file");
my @data;

while(<IN>){
    chomp;
    s/;/\t/g;
    my @data = split("\t",$_);
    if($data[7] =~ /transcript_id/) {
	print "$data[0]\t$data[1]\t$data[2]\t$data[3]\t$data[4]\t$data[7]\t$data[5]\n";	
# Pogona
#	print "$data[0]\t$data[1]\t$data[2]\t$data[3]\t$data[4]\t$data[5]\n";	
    }
}
