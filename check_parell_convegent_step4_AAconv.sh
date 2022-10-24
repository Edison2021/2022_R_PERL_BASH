# $1 is env4.PC.res.txt 
awk '{print $1 }' $1>1.tmp
~/src/breaknamelist2.pl 1.tmp
echo "classfy snp"
#!/bin/sh
for f in *.fg; do
grep -f $f $1>$f.0.tmp
grep -f $f $1| awk '{print $4}' |sed 's/_/ /g' | awk '{print $1}'|sort|uniq -c | awk '($1>1)' |awk '{print $2}'|sed  's/$/_/g' >$f.1.tmp
grep -f $f.1.tmp $f.0.tmp|sort -k4>$f.ok
done
cat *.ok >Parallell.list
rm *.fg *.fg.*  1.tmp
