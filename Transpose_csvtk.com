#transpose the matrix 
~/src/csvtk tab2csv $1 | ~/src/csvtk transpose | ~/src/csvtk csv2tab>$1.tr.txt
