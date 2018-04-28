#!/usr/bin/perl
# Author: Resul Serkan Keskin, 14011029, YTU CE

use strict;
use warnings;

# window parameters
my $win = 15; # Window Size
my $str = 15; # Stringency

# read from files
open IN, "<input1.txt"  or die "Can't open input1.txt: $!";
my $seq1 = do { local $/; <IN> };
close IN or warn "Can't close input1.txt: $!";
chomp $seq1;
my @seq1 = split //, $seq1;

open IN, "<input2.txt"  or die "Can't open input2.txt: $!";
my $seq2 = do { local $/; <IN> };
close IN or warn "Can't close input2.txt: $!";
chomp $seq2;
my @seq2 = split //, $seq2;

# init params
my @plot;
my $x = 0;
my $cnt = 0;
push @plot, [(' ') x ($#seq1 + 1)] for (0..$#seq2);

# fill matrix
for my $i (0 .. ($#seq2 - $win + 1)) {
	for my $j (0 .. ($#seq1 - $win + 1)) {
		$x = 0;
		$cnt = 0;
		while (($cnt < $str)  and ($x < $win)){
			if ($seq2[$i + $x] eq $seq1[$j + $x]) {
				$cnt = $cnt + 1;
			}
			$x = $x + 1;
		}
		if ($cnt >= $str){
			$plot[$i + int ($win / 2)][$j + int ($win / 2)]="·";
		}
	}}

# print to file
open OUT, ">output.txt" or die "Can't open output.txt: $!";
print OUT "  ";
for my $j (0 .. $#seq1) {
	print OUT "$seq1[$j] ";
}
print OUT "\n";
for my $i (0 .. $#seq2) {
	print OUT "$seq2[$i] ";
	for my $j (0 .. $#seq1) {
		print OUT "$plot[$i][$j] ";
	}
	print OUT "\n"
}
close OUT or warn "Can't close output.txt: $!";
