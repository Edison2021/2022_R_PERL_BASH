#$1 paralle for each strain; $2 is sorted total OG for all genomes; this scripst constrcut the AP martrix
awk '{print $6}' $1 |sort>0.tmp
comm -12 0.tmp $2 >1.tmp
grep -w -f 1.tmp $1 |awk '{print $6 "\t" $2}'>sh.list
comm -23 $2 0.tmp>2.tmp
awk '{print $1 "\t" "0"}' 2.tmp>nonsh.lsit
cat sh.list nonsh.lsit |sort -k 1  >$1.ok
rm 0.tmp 1.tmp 2.tmp sh.list nonsh.lsit
#FINALLY, you need to paste all matrix together; i will not generate auto verison, you may need to chekc before paste
