#!/usr/bin/perl 

##########################################################
# Add introns between exons  based on same transcript id #
##########################################################

my ($file) = @ARGV;
open(IN,"$file");
my %hash;
my $chr;
my @tmp;
my $info;
my $val;
my $i=0;
my @gene_id;
my @chr;
my $test;
my @array1="";
my $chr_pre="";
my $chr_aft="";
my @all_keys;

# Read File
while(<IN>) {
    @tmp = split("\t",$_);
    $chr = $tmp[0].$tmp[5];
    next if ($tmp[0] =~ /\_/ );
    $hash{$chr} = $hash{$chr}.$_;
    $chr_aft = $chr;
    if($chr_aft ne $chr_pre){
	push (@all_keys,$chr_aft);
	$chr_pre=$chr_aft;
    }else{
	$chr_pre=$chr_aft;
    }
}

# Add intron
foreach $val  (@all_keys) {
    @gene_id = split("\n",$hash{$val});
    @array1 = "";
    foreach $test_tmp (@gene_id) {
	@test = split("\t",$test_tmp);
	if ($test[4] eq "exon") {
	    push (@array1, $test[1]);
	    push (@array1, $test[2]);
	}	
    }
    pop(@array1);
    shift(@array1);
    shift(@array1);
    foreach $test_tmp (@gene_id) {
	@test = split("\t",$test_tmp);
	if ($test[4] eq "exon" && $array1[0] ne "") {
	    print $test_tmp."\n";
	    $start=shift(@array1);
	    $end=shift(@array1);
	    $start=$start+1;
	    $end=$end-1;
	    $out=join("\t",$test[0],$start, $end, $test[3], "intron", $test[5], $test[6]);
	    print $out."\n";		    
	}else{
	    print $test_tmp."\n";
	}
    }       	
}

