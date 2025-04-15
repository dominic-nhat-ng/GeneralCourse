#!/usr/bin/perl
use strict;
use warnings;
use Term::ANSIColor qw(:constants);

my $filename = $ARGV[0];
open(FILE, $filename) or die("Unable to open file");
my $byte_cnt = 0;
my $trans_id = 0;
my $trans=0;
my %hash_field;
my $nested = 1;
while ( my $line = <FILE>) 
	{
	if($line =~ m/sequence_library.nested_sequence/) {
		$nested = 4;
	}
	if($line =~ m/iterations.*UVM_SEQ_LIB_RAND/) {
  		my $str = $line;
        	my ($f, $f1, $f2)= split /:/,$str;
        	$f2 =~ m/(\d+)/;
        	$trans = $1;
	}
        for (my $i=1; $i <= $trans; $i++) {
        		if($line =~ m/secure_data_out.*byte/) {
       		 		my $str1 = $line;
       		 		my ($f3, $f4, $f5)= split /#/,$str1;
       		 		$f5 =~ m/(\d+)/;
       		 		$trans_id = $1;
       		 		$f4 =~ m/(\d+)/;
       		 		my $trans2 = $1;
        
        
       		 	if( $trans_id == $i ) {
       		   		if( $trans2 <= (16 * $nested )) {
       		     			$byte_cnt = $byte_cnt + 1;
       		     			$hash_field{$i} = $byte_cnt; 
       		     			if($trans2 == (16 * $nested)) { $byte_cnt = 0;}
       		   		}
        		}
		}
        }
}
	if(eof) {print BOLD "Number of Transactions Sent $trans\n";}
        if(eof) {for (my $i=1; $i <= $trans; $i++) 
		{print BOLD "Received $hash_field{$i} bytes from transaction $i expected "; print $nested*16; print "\n";}}
exit 1;
