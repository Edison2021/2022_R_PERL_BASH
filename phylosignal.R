library(phylosignal)
library(adephylo)
library(ape)
library(phylobase)
p4d<-read.p4d("rooted.nwk","trait.txt",phylo.format="newick",data.format="table") 
barplot.phylo4d(p4d, tree.type = "phylo", tree.ladderize = TRUE)
barplot(p4d, tree.type = "fan", tip.cex = 0.6, tree.open.angle = 160, trait.cex = 0.6)
barplot(p4d, trait.bg.col = c("#F6CED8", "#CED8F6", "#CEF6CE"), bar.col = "grey35")
barplot(p4d, center= FALSE, trait.bg.col = c("#F6CED8", "#CED8F6", "#CEF6CE"), bar.col = "grey35")
phyloSignal(p4d = p4d, method = "all")
crlg <- phyloCorrelogram(p4d, trait = "glu")
plot(crlg)
##############
Inputformat
nwk format is tree without bootstrap
table format
Species trait1 trait2 trait3
S1 2 3 4
S2 5 6 7
S3 8 9 01
note: only continuous traits data allowed.

