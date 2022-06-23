# input is the gd files
# consider the actial population number
echo "extract population number"
~/src/csvtk csv2tab  $1 |awk -F '\t' '{print $45 "\t" $46}' >0.tmp
grep 'Glu' 0.tmp |awk '{print $1}' |sort | uniq -c | awk '{print $2}' |wc -l >0.u.tmp
grep 'Gal' 0.tmp |awk '{print $1}' |sort | uniq -c | awk '{print $2}' |wc -l >0.l.tmp
grep 'Gly' 0.tmp |awk '{print $1}' |sort | uniq -c | awk '{print $2}' |wc -l >0.y.tmp
grep 'Sor' 0.tmp |awk '{print $1}' |sort | uniq -c | awk '{print $2}' |wc -l >0.s.tmp
sed 'p;p;p;p;p;p;p' 0.u.tmp>0.u.1.tmp
sed 'p;p;p;p;p;p;p' 0.l.tmp>0.l.1.tmp
sed 'p;p;p;p;p;p;p' 0.y.tmp>0.y.1.tmp
sed 'p;p;p;p;p;p;p' 0.s.tmp>0.s.1.tmp
echo "extract mutation info"
~/src/csvtk csv2tab  $1 |awk -F '\t' '{print $46 "\t" $22}' >1.tmp
grep 'Glu' 1.tmp |awk '{print $2}' |sort | uniq -c | awk '{print $2 "\t" $1 "\t" "glu"}' | awk '($3!="")' >$1.glu.ok
grep 'Gal' 1.tmp |awk '{print $2}' |sort | uniq -c | awk '{print $2 "\t" $1 "\t" "gal"}' | awk '($3!="")' >$1.gal.ok
grep 'Gly' 1.tmp |awk '{print $2}' |sort | uniq -c | awk '{print $2 "\t" $1 "\t" "gly"}' | awk '($3!="")' >$1.gly.ok
grep 'Sor' 1.tmp |awk '{print $2}' |sort | uniq -c | awk '{print $2 "\t" $1 "\t" "sor"}' | awk '($3!="")' >$1.sor.ok
grep -f alltyp.list $1.glu.ok>$1.glu.1.ok
grep -f alltyp.list $1.gly.ok>$1.gly.1.ok
grep -f alltyp.list $1.gal.ok>$1.gal.1.ok
grep -f alltyp.list $1.sor.ok>$1.sor.1.ok
echo "combine pop number and mutation info"
paste 0.u.1.tmp $1.glu.1.ok| awk '($2!="")' |awk '{print $2 "\t" $3/$1 "\t" $4 }' >$1.mtype.txt
paste 0.l.1.tmp $1.gal.1.ok| awk '($2!="")' |awk '{print $2 "\t" $3/$1 "\t" $4 }' >>$1.mtype.txt
paste 0.y.1.tmp $1.gly.1.ok| awk '($2!="")' |awk '{print $2 "\t" $3/$1 "\t" $4 }' >>$1.mtype.txt
paste 0.s.1.tmp $1.sor.1.ok| awk '($2!="")' |awk '{print $2 "\t" $3/$1 "\t" $4 }' >>$1.mtype.txt
awk '($2!="")' $1.mtype.txt >$1.mAtype.txt
rm  1.tmp 0.tmp 0.u.tmp 0.l.tmp 0.y.tmp 0.s.tmp $1.glu.ok $1.gal.ok $1.gly.ok $1.sor.ok 0.u.1.tmp 0.l.1.tmp 0.y.1.tmp 0.s.1.tmp $1.glu.1.ok $1.gly.1.ok $1.gal.1.ok $1.sor.1.ok  $1.mtype.txt 
