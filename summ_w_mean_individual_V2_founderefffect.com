#$1 is all list; $2 is the w cal file;$3 is job name
#updated the all list to all strains this will take founder effect as founder effect * reletvie fitness
~/src/filter_cal.com $2
awk '($37>0)' $2.flt|grep 'evo'  | grep 'Good' | grep 'Include' |awk '{print $20 "\t" "G"$18 "\t" $37 "\t" $4}' >1.tmp
awk '($37>0)' $2.flt|grep 'founder'  | grep 'Good' | grep 'Include' |awk '{print $20 "\t" "G"$18 "\t" $37 "\t" $4}' >0.tmp
~/src/breaknamelist2.pl $1
for f in *.fg;do
grep -f $f 1.tmp|awk '{print $4 "_" $1 "\t" $3 }'>2.tmp
grep -f $f 0.tmp|awk '{print   $4 "\t" $3}' >2.1.tmp
datamash --sort --group 1 mean 2 <2.1.tmp>2.2.tmp
awk '{k=$1=$1; sub(k,x); A[k]=A[k] $0} END{for(i in A)print i A[i]}' 2.tmp|sed 's/ /\t/g' >3.tmp
awk '{print $1}' 3.tmp >3.1.tmp
cut -f 2- 3.tmp  | awk '{sum = 0; for (i = 1; i <= NF; i++) sum += $i; sum /= NF; print sum}'  >4.tmp
paste 3.1.tmp 4.tmp >$f.meanw.txt
~/src/replace.pl $f.meanw.txt 2.2.tmp |sed 's/_/\t/g' |  awk '{print $2 "\t" $1*(1/$3)}' >$f.meanw.0.txt
rm 2.tmp 3.tmp 3.1.tmp 4.tmp 2.1.tmp 2.2.tmp 
done
rm 1.tmp *.fg 0.tmp 
~/src/combiane_files_noeqaullines_NA.pl *.meanw.txt>6.tmp
~/src/combiane_files_noeqaullines_NA.pl  *.meanw.0.txt>5.tmp

awk '{ for (i=1;i<=NF;i+=2) $i="" }1'  5.tmp  >5.tmp.data
awk '{ for (i=2;i<=NF;i+=2) $i="" }1' 5.tmp| head -n 1 >5.tmp.name

awk '{ for (i=1;i<=NF;i+=2) $i="" }1'  6.tmp  >6.tmp.data
awk '{ for (i=2;i<=NF;i+=2) $i="" }1' 6.tmp| head -n 1 >6.tmp.name
cat 6.tmp.name 6.tmp.data >$3.noadjust.txt
cat 5.tmp.name 5.tmp.data >$3.txt
rm *.fg.* 5.tmp.data 5.tmp 5.tmp.name 6.tmp.data 6.tmp.name 6.tmp
