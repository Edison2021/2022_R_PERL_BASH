#!/usr/bin/env Rscript
#D = 1 if the distribution of the binary trait is random with respect to phylogeny, and >1 if the distribution of the trait is more overdispersed than the random expectation.D = 0 if the binary trait is distributed as expected under the Brownian motion model of evolution, and <0 if the binary trait is more phylogenetically conserved than the Brownian expectation.
# $1 is trait table;$2 is tre file;names.col is species name column;binvar is trait column.
# only for binary trait
# usage Rscript Dstatistic.R 1.tab 1.nwk Biomial Nocturnal

library("caper")
args = commandArgs(trailingOnly=TRUE)
sink(file= args[5])
dat <-read.table(args[1], sep = "\t", header =TRUE)
tre<-read.tree(file= args[2])
#tre <-read.nexus(args[2])
D <- comparative.data(phy = tre, data = dat, names.col = Species, vcv = TRUE, na.omit = FALSE, warn.dropped = TRUE)
result <-phylo.d(data=D, binvar = trait, permut = 1000)
print(result)
#format
#tre ((((((((Allenopithecus_nigroviridis:13.350134,(((((((Cercopithecus_ascanius:2.108541.....
#dat 
#Order   Family  Binomial        Nocturnal
#Primates        Aotidae Aotus_trivirgatus       1
#Primates        Atelidae        Ateles_belzebuth        0

