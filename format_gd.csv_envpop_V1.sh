# this script ignore pesodogenee
# $1 is gd file; $2 is gff file; this will output mutated genes 
~/src/csvtk csv2tab  $1 | awk -F '\t' '{print $34 "\t" $28 "\t" $27 "\t" $11"_"$29"_"$24"_"$46"\t"$36 "\t" $3$2$1 "\t" $45$46}'>1.tmp 
grep -f  list.txt 1.tmp>SNP.loci
awk '($3=="CDS")' $2 |sed 's/;/ /g' | awk '{print $1 "\t" $4 "\t" $5 "\t" $9}' >gff.loci
bedtools intersect -a gff.loci  -b SNP.loci -wo |awk '{print $4 "\t" $8 "\t" $9 "\t" $10 "\t" $11}'|sed 's/ID=//g' >$1.mutatedSNP.txt
sed -i 's/^/'$1'\t/g' $1.mutatedSNP.txt
rm gff.loci SNP.loci 1.tmp 
