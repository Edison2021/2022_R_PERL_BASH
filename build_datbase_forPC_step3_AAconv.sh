# $1 is  total OG list; $2 is total  og and gene info;  $3 is total gene and snp info; $4 is job name
echo "split OGs"
awk '{print $1 "n"}' $1>1.tmp
~/src/breaknamelist2.pl 1.tmp
echo "compare snp"
#!/bin/sh
for f in *.fg; do
grep -f $f $2| awk '{print $1}' >$f.list
grep -f $f.list $3>$f.snp.pc.txt
sed -i 's/^/'$f'\t/g' $f.snp.pc.txt
done
cat *.snp.pc.txt>$4.PC.res.txt
echo "done"
rm *.fg *.fg.* -f   1.tmp
