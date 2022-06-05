#$1 is tre; $2 is dat
# demo http://www.francoiskeck.fr/phylosignal/demo_plots.html
#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
library(phylosignal)
library(adephylo)
library(ape)
library(phylobase)
p4d<-read.p4d(args[1],args[2],phylo.format="newick",data.format="table") 
#barplot.phylo4d(p4d, tree.type = "phylo", tree.ladderize = TRUE)
#barplot(p4d, tree.type = "fan", tip.cex = 0.6, tree.open.angle = 160, trait.cex = 0.6)
#barplot(p4d, trait.bg.col = c("#F6CED8", "#CED8F6", "#CEF6CE"), bar.col = "grey35")
# this will plot the traits; default is center=TRUE and scale=TRUE
#If center is TRUE then centering is done by subtracting the column means (omitting NAs) of x from their corresponding columns.
#If scale is TRUE then scaling is done by dividing the (centered) columns of x by their standard deviations if center is TRUE, and the root mean square otherwise. 
#barplot(p4d, center= FALSE, trait.bg.col = c("#F6CED8", "#CED8F6", "#CEF6CE","#FFE5CC"), bar.col = "grey35")
barplot(p4d, trait.bg.col = c("#F6CED8", "#CED8F6", "#CEF6CE","#FFE5CC"), bar.col = "grey35")
# this will calcualte signal
phyloSignal(p4d = p4d, method = "all")
# this will plot correaltion for "glu" trait
crlg <- phyloCorrelogram(p4d, trait = "glu")
plot(crlg)
##############
#Inputformat
#nwk format is tree without bootstrap
#table format
#Species trait1 trait2 trait3
#S1 2 3 4
#S2 5 6 7
#S3 8 9 01
#note: only continuous traits data allowed.
#K < 1, the evolution of traits is independent of the phylogeny, and when K > 1 they are dependent of the phylogeny, any large value possible
#This statistic can indicate little or no phylogenetic signal (0<K < 1)
#λ = 0 indicating no phylogenetic signal, 1 indicating a strong phylogenetic signal, value falls bwtween 0~1
#I equals 0, species resemble each other as much as predicted under a brownian motion model. <0, less than predicted under a brownian motion model.
#> 0, closely related species are more similar. Cmean simlar to I value
