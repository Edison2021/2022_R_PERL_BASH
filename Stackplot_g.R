#!/usr/bin/env Rscript
# $1 is data $2 is pdf name; change color limit each time
args = commandArgs(trailingOnly=TRUE)
library(ggplot2)
df<-read.table(args[1])
#df<-read.table(args[1], header=T)
library(ggplot2)
pdf(args[2])
ggplot(df, aes(fill=V1, y=V2, x=V3)) +geom_bar(position="fill", stat="identity")+facet_wrap(~V4)
dev.off()
#format
#mutation_type value conditon species
#DEL	1.5	glu TW15991
#INS	0.75	glu TW15991
#nonsense	0.25	glu TW15991
#nonsynonymous	2	glu TW15991
#SUB	0.25	glu TW15991
#DEL	1	gal TW15992
#nonsense	0.5	gal TW15992
#nonsynonymous	0.5	gal TW15992
#DEL	2	gly TW15992
#INS	0.5	gly TW15992

