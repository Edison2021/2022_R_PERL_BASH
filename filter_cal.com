awk -F '\t' '($30==5000 && $25==5000)' $1 | awk '{print $21}' |sort | uniq -c | awk '($1>=3)' |awk '{print $2}' >kp.list
grep -w -f kp.list  $1 >0.tmp
awk -F '\t' '($10!="blank"&&$15!="Exclude")' 0.tmp>1.tmp
awk -F '\t' '($37>0 && $37<5 && $35>0 && $36>0 && $30==5000 && $25==5000)' 1.tmp >$1.flt
rm 1.tmp 0.tmp
