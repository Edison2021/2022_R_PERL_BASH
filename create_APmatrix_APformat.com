#$1 is the sorted presence list in a genome; $2 is sorted total presecne in all genomes; this scripst constrcut the AP martrix
#only for one by one species and finally paste by
comm -12 $1 $2 >1.tmp
awk '{print $1 "\t" "1"}' 1.tmp >sh.list 
#paste 1.tmp 1.tmp >sh.list
comm -23 $2 $1>2.tmp
awk '{print $1 "\t" "0"}' 2.tmp>nonsh.lsit
cat sh.list nonsh.lsit |sort -k 1  >$1.ok
#cat sh.list nonsh.lsit |sort -k 1  |awk '{print $2}'>$1.ok
rm 1.tmp 2.tmp sh.list nonsh.lsit
#FINALLY, you need to paste all matrix together; i will not generate auto verison, you may need to chekc before paste
