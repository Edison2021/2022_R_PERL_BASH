##calculate and compare different metrics for assessing strain specialism-generalism
library(corrgram) #for correlogram
library(Hmisc) #rcorr matrix of correlations
args = commandArgs(trailingOnly=TRUE)
df<-read.table(args[1])
#input is a normolized file by max value for each grwoth condition 
#calculate specialist-generalist (s.g) metrics and normalize by max (excep for mean)
#s.g metric based on mean
sg.M = rowMeans(df)
#s.g metric based on SD
sg.SD = apply(df, 1, FUN=sd)
#s.g metric based on CV
sg.CV = sg.SD / sg.M
# normalize by max
sg.SD = sg.SD/max(sg.SD)
sg.CV = sg.CV/max(sg.CV)
#data frame collating metrics
sg = cbind(sg.M, sg.SD, sg.CV)
write.table (sg, file="Metric.txt", sep="\t")
#correlogram text and figure
r=rcorr(sg, type=c("pearson"))#pearson
print(r)
corrgram(sg, order=TRUE, lower.panel=NULL, 
	upper.panel=panel.pts, text.panel=panel.txt,
	diag.panel=panel.minmax)
