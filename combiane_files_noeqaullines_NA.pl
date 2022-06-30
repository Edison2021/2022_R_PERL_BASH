# paste upto 40 files
gawk '
BEGIN {
    FS=OFS="\t"                                                   # set delimiters
}
{
    for(i=1;i<=NF;i++)                                            # iterate data fields
        a[FNR][s+i]=$i                                            # hash them
}
ENDFILE {
    s+=NF                                                         # store field count
}
END {
    for(i in a) {                                                 # in awk order
        for(j=1;j<=s;j++)                                         # and data
            printf "%s%s",(a[i][j]==""?"NA":a[i][j]),(j==s?ORS:OFS)  # output
    }
}'  $1 $2 $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14 $15 $16 $17 $18 $19 $20 $21 $22 $23 $24 $25 $26 $27 $28 $29 $30 $31 $32 $33 $34 $35 $36 $37 $38 $39 $40
