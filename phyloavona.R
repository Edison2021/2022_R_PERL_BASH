#the inputable :first cell is must empty
# will test if the group is associated with trait 
library(phytools)
library(geiger)
args = commandArgs(trailingOnly=TRUE)
dat<-read.table(args[1],header=T)
tree <- read.tree(args[2])# rooted tree
# tree<- drop.tip(tree,c("taxon0","taxon1")) if you need to drop tips
trdm <- treedata(tree, dat, sort = TRUE)# sort the order to be consistent 
tree1<-trdm$phy
dat1<-trdm$data
phylANOVA(tree1, dat1[,2],dat1[,1],nsim=1000,posthoc=TRUE, p.adj="holm") # dat1[,1]=fitness;dat1[,2]=g1
# input tab format
#        fitness g1 g2
#WB15974 1.000000  1  0
#WB15940 0.706134  0  1
#WB15944 0.554627  1  1
#WB16000 0.551798  0  0
#WB15950 0.481037  0  0
#WB15929 0.493890  0  0
#WB15952 0.483843  0  1

