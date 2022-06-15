#!/usr/bin/env Rscript
# $1 is data $2 is pdf name; change color limit each time
args = commandArgs(trailingOnly=TRUE)
library(ggplot2)
df<-read.table(args[1])
#df<-read.table(args[1], header=T)
library(ggplot2)
pdf(args[2])
ggplot(df, aes(fill=V1, y=V2, x=V3)) +geom_bar(position="fill", stat="identity")
dev.off()
#format
#DEL	1.5	glu
#INS	0.75	glu
#nonsense	0.25	glu
#nonsynonymous	2	glu
#SUB	0.25	glu
#DEL	1	gal
#nonsense	0.5	gal
#nonsynonymous	0.5	gal
#DEL	2	gly
#INS	0.5	gly

