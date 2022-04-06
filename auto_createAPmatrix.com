# this will create AP matrix, you will need sperate_APformat.com and create_APmatrix_APformat.com
############format $1 you only need first two columns##################
#algC_2n REL606_A+4      REL606_01975    1092_C_T_Glu    synonymous      V364V
#algC_2n TW15944 JIDAHDOE_00562  1346_A_G_Glu    nonsynonymous   L449P
#############format $2 is a species list including all species you study###############
# REL606
# TW15944
#######################################
echo "sperating the presecne list for each gene"
~/src/sperate_APformat.com $1 
echo "making matrix for each genome"
#!/bin/sh
for f in *.P.txt; do
~/src/create_APmatrix_APformat.com $f $2
done
echo "generating final matrix"
paste *.ok >1.tmp
# you may need to change the n.fg.P.txt.ok in other cases
ls *.ok | sed  ':a;N;$!ba;s/\n/\t/g'| sed '1s/^/Species\t/g'| sed 's/n.fg.P.txt.ok//g'>gene.list
awk '{line=""; for (i=2;i<=NF;i+=2) line=line ("\t" $i); print $1 line;}' 1.tmp >2.tmp
cat gene.list 2.tmp >$1.matrix.txt
rm  *.fg.* 1.tmp 2.tmp gene.list  
