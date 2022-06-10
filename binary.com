#use set ff=unix to set format__ last column is bug if file in dos format
awk 'BEGIN { OFS = FS = "\t" } NR != 1 {for (i = 2; i <= NF; ++i) {if ($i != "0") {$i = "1";}}}{ print }' $1>$1.ok
