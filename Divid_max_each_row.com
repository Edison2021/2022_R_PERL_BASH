# normalize in the same conditpon

awk '
FNR==1{
  print;
  next
}
{
  len=""
  for(i=2;i<=NF;i++){
     len=len>$i?len:$i};
  printf("%s%s", $1, OFS)
}
{
  for(i=2;i<=NF;i++){
     printf("%s%s",$i>0?$i/len:0,i==NF?RS:FS)}
}' $1 >$1.nor.txt
sed -i 's/ /\t/g' $1.nor.txt

######informat
#r	s1	s2	s3	s4
#a1	1	2	3	4
#a2	5	6	7	8
#a3	9	10	11	12

