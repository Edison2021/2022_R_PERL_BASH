#$1 is G S list; $2 is the w cal file;$3 is job name
awk '($37>0)' $2|grep 'evo'  | grep 'Good' | grep 'Include' |awk '{print $20 "\t" "G"$18 "\t" $37}' >1.tmp
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

~/src/combiane_files_noeqaullines_NA.pl  *.meanw.txt>$3.txt

#cat *.meanw.txt |awk '{print $2}' >$3.txt
rm *.fg.*
