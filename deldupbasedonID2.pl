# remove reduant copy
awk '{f=!d[$1];d[$1]=1}f' $1>$1.uniq.out
