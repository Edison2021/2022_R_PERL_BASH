# $1 is snp gene; $2 is roary absence presence martix; change 2917 based on how mnay isolations you have; $3 is aa seq in a genome; $4 is job name
echo "calculating mutated genes classes"
~/src/genome/match.listorder.pl $2 $1 | awk -F '\t' '{print $1 "\t" $4/2917}'   >$1.fre.txt
echo "calculating gene length"
awk '/^>/ {if (seqlen){print seqlen}; print ;seqlen=0;next; } { seqlen = seqlen +length($0)}END{print seqlen}'  $3| sed 'N;s/\n/\t/g' |sed 's/>//g' >length.txt
echo "calculating length of each gene class"
awk '{print $1}' length.txt>name.list
~/src/genome/match.listorder.pl $2 name.list | awk -F '\t' '{print  $4/2917}'   >all.fre0.txt
paste name.list all.fre0.txt>all.fre.txt
awk '($2>0.9)'          all.fre.txt |awk '{print $1}' >10.genefre.txt
awk '($2>0.8&&$2<0.9)'  all.fre.txt |awk '{print $1}' >9.genefre.txt
awk '($2>0.7&&$2<0.8)'  all.fre.txt |awk '{print $1}' >8.genefre.txt
awk '($2>0.6&&$2<0.7)'  all.fre.txt |awk '{print $1}' >7.genefre.txt
awk '($2>0.5&&$2<0.6)'  all.fre.txt |awk '{print $1}' >6.genefre.txt
awk '($2>0.4&&$2<0.5)'  all.fre.txt |awk '{print $1}' >5.genefre.txt
awk '($2>0.3&&$2<0.4)'  all.fre.txt |awk '{print $1}' >4.genefre.txt
awk '($2>0.2&&$2<0.3)'  all.fre.txt |awk '{print $1}' >3.genefre.txt
awk '($2>0.1&&$2<0.2)'  all.fre.txt |awk '{print $1}' >2.genefre.txt
awk '($2<0.1)'          all.fre.txt |awk '{print $1}' >1.genefre.txt
#!/bin/sh
for f in *.genefre.txt; do
grep -f $f length.txt|awk '{sum+=$2;} END{print sum;}' >$f.length
done
echo "adding mutated genes to each class"
awk '($2>0.9)'          $1.fre.txt |wc -l  >>10.genefre.txt.length
awk '($2>0.8&&$2<0.9)'  $1.fre.txt |wc -l  >>9.genefre.txt.length
awk '($2>0.7&&$2<0.8)'  $1.fre.txt |wc -l  >>8.genefre.txt.length
awk '($2>0.6&&$2<0.7)'  $1.fre.txt |wc -l  >>7.genefre.txt.length
awk '($2>0.5&&$2<0.6)'  $1.fre.txt |wc -l  >>6.genefre.txt.length
awk '($2>0.4&&$2<0.5)'  $1.fre.txt |wc -l  >>5.genefre.txt.length
awk '($2>0.3&&$2<0.4)'  $1.fre.txt |wc -l  >>4.genefre.txt.length
awk '($2>0.2&&$2<0.3)'  $1.fre.txt |wc -l  >>3.genefre.txt.length
awk '($2>0.1&&$2<0.2)'  $1.fre.txt |wc -l  >>2.genefre.txt.length
awk '($2<0.1)'          $1.fre.txt |wc -l  >>1.genefre.txt.length
#!/bin/sh
for f in *.genefre.txt.length; do
sed 'N;s/\n/\t/g' $f >$f.tmp
done
# the order is from core to accesry
cat 10.genefre.txt.length.tmp 9.genefre.txt.length.tmp 8.genefre.txt.length.tmp 7.genefre.txt.length.tmp 6.genefre.txt.length.tmp 5.genefre.txt.length.tmp 4.genefre.txt.length.tmp 3.genefre.txt.length.tmp 2.genefre.txt.length.tmp 1.genefre.txt.length.tmp >$4.snp.fre.txt
echo "finished"


rm $1.fre.txt 
rm *tmp  *.length *.genefre.txt 
rm all.fre0.txt name.list length.txt
