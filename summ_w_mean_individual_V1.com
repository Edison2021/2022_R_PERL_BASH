#$1 is G S list; $2 is the w cal file;$3 is job name
awk '($37>0)' $2|grep 'evo'  | grep 'Good' | grep 'Include' |awk '{print $20 "\t" "G"$18 "\t" $37}' >1.tmp
~/src/breaknamelist2.pl $1
for f in *.fg;do
grep -f $f 1.tmp|awk '{print $1 "\t" $3}'>2.tmp
awk '{k=$1=$1; sub(k,x); A[k]=A[k] $0} END{for(i in A)print i A[i]}' 2.tmp|sed 's/ /\t/g' >3.tmp
awk '{print $1}' 3.tmp|head -n 1 >3.1.tmp
cut -f 2- 3.tmp| awk '{sum = 0; for (i = 1; i <= NF; i++) sum += $i; sum /= NF; print sum}'  >4.tmp
cat 3.1.tmp 4.tmp >$f.meanw.txt
rm 2.tmp 3.tmp 3.1.tmp 4.tmp
done
rm 1.tmp *.fg

~/src/combiane_files_noeqaullines_NA.pl  *.meanw.txt>$3.txt

#cat *.meanw.txt |awk '{print $2}' >$3.txt
rm *.fg.*

#format
env	type	order	evo.block	seqd	founder	founder.ab	pop.no	old.nf	gfp	rep	well	matching.ref	status	in.ex	re.pop.no	pop.founder	cons.founder	re.popID	re.nfID	new.ID	evo.well	fit.well	no.days	d1.total	d1.nfcount	d1.nf	d1.gfpcount	d1.gfp	d1.total.1	d2.nfcount	d2.nf	d2.gfpcount	d2.gfp	m.evo	m.anc	w
gal	evo	88	galA	ns	15929	29	137	29-1	300	1	H04	DEAD	Dead	Exclude	137	Dead	15929	15929-1	29-1	GalA-29-1	H04	H04	1	5000	91	0.0182	4909	0.9818	5000	181	0.0362	4819	0.9638	5.29280771073707	4.58666636857037	1.15395524448987
gal	evo	184	galA	ns	15929	29	137	29-1	300	2	H04	DEAD	Dead	Exclude	137	Dead	15929	15929-1	29-1	GalA-29-1
