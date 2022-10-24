# $1 is OG list;  $2 is OG list and gene names; $3 is nt seq in the genome incluing all seq; $4 is job name
echo "split OGs"
awk '{print $1 "n"}' $1>1.tmp
~/src/breaknamelist2.pl 1.tmp
echo "do alingment"
#!/bin/sh
for f in *.fg; do
grep -f $f $2| awk '{print $1}' >$f.list
seqtk subseq $3 $f.list >$f.fa
~/src/fastaln_auto.pl $f.fa
grep  -Fo '-'  $f.fa.aln|wc -l>$f.gap.0.txt
sed 's/^/'$f'\t/g' $f.gap.0.txt>$f.gap.1.txt
done
cat *gap.1.txt>$4.result.txt
rm 1.tmp *.fg *.fg.*
echo "done"
