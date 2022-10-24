awk '{print $2 "_"$6}' $1 >1.tmp
awk '{f=!d[$1];d[$1]=1}f' 1.tmp >2.tmp
sed  's/\(.*\)_/\1 /g' 2.tmp|awk '{print $1}' |sort | uniq -c | awk '($1>1)' | awk '{print $2 "\t" $1}' >$1.ok

rm 1.tmp 2.tmp
