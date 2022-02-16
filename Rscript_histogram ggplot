#!/usr/bin/env Rscript
# $1 is data $2 is pdf name; change color limit each time
args = commandArgs(trailingOnly=TRUE)
library(ggplot2)
df<-read.table(args[1], header=T)
#Turn your 'treatment' column into a character vector
df$GROUP <- as.character(df$GROUP)
#Then turn it back into a factor with the levels in the correct order
df$GROUP <- factor(df$GROUP, levels=unique(df$GROUP))
pdf(args[2])
ggplot(df, aes(GROUP, SNP)) + geom_bar(aes(fill = Color), position = "dodge", stat="identity") + scale_fill_manual(values=c("Blue", "Red")) +  facet_grid(. ~ Color, scales = "free_x", space = "free_x") + theme(axis.text.x=element_text(angle=45,hjust=1))
dev.off()
##############
#SNP	GROUP Color
#28.15156804	Con  B
#34.08938724	Con  B
#8.745080892	Test B
#16.86710409	Test B
#15.11001983	Test B
################
# oeder as you want y x z df$GROUP <- factor(data$GROUP, levels=c("Y", "X", "Z"))
