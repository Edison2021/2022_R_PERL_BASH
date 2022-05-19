# remove bootstrap
#~/src/gotree_amd64_linux support clear  -i IQ_tree.final.nwk -o IQ_tree.final.nobt.nwk     
# keep tips; $1 is tree file and $2 is keep list. 
#~/src/gotree_amd64_linux prune  -i $1 -o $2.nwk -f $2 -r
#convert nexus to nwk
#~/src/gotree_amd64_linux  reformat newick -i $1 -f nexus -o $1.nwk
# extract gene/species name
#~/src/gotree_amd64_linux labels -i $1
# assgin random length to branch
~/src/gotree_amd64_linux   brlen setrand -i $1  -o $1.rand.nwk --seed 13
