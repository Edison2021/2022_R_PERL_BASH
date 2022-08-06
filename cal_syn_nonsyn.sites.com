# $1 is coding seq in axt format; using NG for eaual freqncy
#~/src/KaKs_Calculator -i $1 -o $1.res -m YN -c 11
~/src/KaKs_Calculator -i $1 -o $1.res -m NG -c 11 
awk '{print $8}' $1.res>$1.s.txt
awk '{print $9}' $1.res>$1.n.txt
rm  $1.res
