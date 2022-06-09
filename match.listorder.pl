#!/usr/bin/perl
#match the same one
($gene,$file)=@ARGV;
	$chk=0;
	open(GENE,"$gene")||die"can't open the file $gene\n";
	while(<GENE>){
			$chk++;
		$story[$chk]=$_;
		}
	
open(FILE,"$file")||die"can't open the file $file\n";
while(<FILE>){
	chomp;
	$n=$_;
	for($jj=1;$jj<=$chk;$jj++){
		$seq=$story[$jj];
		if($n eq ""){
			next;
			}
		if($seq =~/$n/){
			$i=1;
			last;
			}
		}
	if($i==1){
		print $seq;
		}
	$i=0;
	}
