#$1 is G S list; $2 is the w sum file;$3 is job name
grep 'evo' $2 |awk '{print $1 "\t" "G"$3 "\t" $8}' >1.tmp
~/src/breaknamelist2.pl $1
for f in *.fg;do
grep -f $f 1.tmp|awk '{print $1 "\t" $3}'>2.tmp
awk '{k=$1=$1; sub(k,x); A[k]=A[k] $0} END{for(i in A)print i A[i]}' 2.tmp|sed 's/ /\t/g' >3.tmp
awk '{print $1}' 3.tmp|head -n 1 >3.1.tmp
cut -f 2- 3.tmp| awk '{sum = 0; for (i = 1; i <= NF; i++) sum += $i; sum /= NF; print sum}'  >4.tmp
cat 3.1.tmp 4.tmp >$f.meanw.txt
rm 2.tmp 3.tmp 3.1.tmp 4.tmp
done
rm 1.tmp *.fg

~/src/combiane_files_noeqaullines_NA.pl  *.meanw.txt>$3.sum.txt

#cat *.meanw.txt |awk '{print $2}' >$3.txt
rm *.fg.*
#format 
strain	population	founder	env	type	seqd	reps	mean.w	sd	se	ci	ci.up	ci.low
00-1	160	16000	gal	evo	seq	7	1.59824965391953	0.161329589410672	0.0609768532423996	0.288374691925585	1.74243699988232	1.45406230795673
00-2	194	16000	gal	evo	seq	7	1.45245158015912	0.293790590613237	0.111042405756202	0.525147131212642	1.71502514576544	1.18987801455279
