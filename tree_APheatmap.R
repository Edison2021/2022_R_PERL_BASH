#Plots a presence absence heatmap for a given set of genes given a tree
#usage Rscript tree_APheatmap.R -t N13.nwk  -g total.1.matrix.txt.tr.txt -s gene.list -o test.pdf
# adjust the ggtree::vexpand to control margin 
# the first cell must be "Gene" in the dataframe, see line 32
# use csvtk convert format
library(argparse)
library(ggtree)
library(ggplot2)

parser <- ArgumentParser()
parser$add_argument("-t", help = "Newick tree against which genes will be plotted")
parser$add_argument("-g", help = "gene_presence_absence.Rtab from Panaroo")
parser$add_argument("-s", help = "File containing names of genes to be plotted, one per line with no header. These should match the gene names in gene_presence_absence.Rtab")
parser$add_argument("-f", help = "Font size for gene names in heatmap, default 2. This can be adjusted if the names are too large", default = "2")
parser$add_argument("-o", help = "Name of output PDF containing heatmap")
args <- parser$parse_args()

#Import the tree
tree <- read.tree(args$t)
#Import gene_presence_absence.Rtab
genePresenceAbsence <- read.table(args$g,sep="\t",header=TRUE,comment.char="!",check.names=FALSE)
#List of the gene names to be plotted
genesToPlot <- read.table(args$s, sep = "\t", header = FALSE)
outFile <- args$o

#Extract the genes to be plotted
genePresenceAbsencePlot <- genePresenceAbsence[which(genePresenceAbsence[,1] %in% genesToPlot[,1]),]

#Will be filled with the gene presence absence in each sample
geneSummary <- data.frame(matrix(0,ncol=length(genePresenceAbsencePlot[,1]),nrow=(length(genePresenceAbsencePlot[1,])-1)))
rownames(geneSummary) <- names(genePresenceAbsencePlot)[2:length(names(genePresenceAbsencePlot))]
names(geneSummary) <- c(as.matrix(genePresenceAbsencePlot$Gene))

#Iterate through the genes to be plotted and add their presence absence to geneSummary
for (gene in 1:(length(genePresenceAbsencePlot[1,])-1)) {
  geneSummary[gene,] <- genePresenceAbsencePlot[,(gene+1)]}

p <- ggtree(tree) + geom_tiplab() +  ggtree::vexpand(.2, -1) +  ggtree::hexpand(.2, -1)

pdf(outFile)

phylogenyPlot <- gheatmap(p, geneSummary, font.size = as.numeric(args$f),hjust=1, colnames_angle = 45) + scale_fill_continuous(low = "#2166AC", high = "#B2182B")
print(phylogenyPlot)
dev.off()

###format####
#Gene	AV_1554_SS_317	AV_1555_SS_320	AV_1556_SS_324	AV_1557_SS_328	AV_1560_SS_332	AV_1561_SS_333	AV_1562_SS_334	AV_1563_SS_335	AV_1564_SS_338
#rnc	1	1	1	1	1	1	1	1	1
#murD	1	1	1	1	1	1	1	1	1
