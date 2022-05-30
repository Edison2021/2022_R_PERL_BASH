#!/usr/bin/perl
# replace the name using the new name; replace.pl $1(files containing the old the name) and $2 (a table old names \t new name)
($file,$tmp)=@ARGV;
$i=0;
open(TMP,"$tmp")||die"can't open the file $tmp\n";
while(<TMP>){
	@get=split(/\s+/,$_);
	$name1[$i]=$get[0];
	$name2[$i]=$get[1];
	$i++;
	}
close(TMP);
open(FILE,"$file")||die"can't open the file $file\n";
while(<FILE>){
	for($j=$i-1;$j>=0;$j--){
		$_=~s/$name1[$j]/$name2[$j]/g;
		}
	print;
	}
