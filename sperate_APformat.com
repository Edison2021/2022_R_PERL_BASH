# create the presecne list for each gene
awk '{print $1}' $1 >og.list
~/src/breaknamelist2.pl og.list
#!/bin/sh
for f in *.fg; do
grep -f $f $1 |awk '{print $2}'|sort | uniq -c | awk '{print $2}'>$f.P.txt
done

rm *.fg og.list 
