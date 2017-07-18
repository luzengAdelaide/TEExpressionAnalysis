#!/usr/bin/perl -w
use strict;

my ($file)=@ARGV;
open(IN,"$file");

while(<IN>){
    chomp;
    my @data = split("\t",$_);
    print "$data[0]\t$data[3]\t$data[4]\t$data[6]\t$data[2]\t$data[8]\t0\n";    
}
