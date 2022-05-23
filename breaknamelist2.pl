#!/usr/bin/perl
while(<>){
	@get=split(/\t/,$_);
	$name=$get[0];
	chomp $name;
	open(TMP,">$name.fg");
	print TMP $_;
        close(TMP);
     
	}

