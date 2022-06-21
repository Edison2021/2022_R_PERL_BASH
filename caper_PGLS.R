library(caper)
args = commandArgs(trailingOnly=TRUE)
#sink: Send R Output in the screen to a File
sink(file= args[3])
dat <-read.table(args[1], sep = "\t")
tre <-read.nexus(file= args[2])
# names.col speies column, if NA in the tbale, using na.omit= TRUE
primate <- comparative.data(phy = tre, data = dat, names.col = V1, vcv = TRUE, na.omit = TRUE, warn.dropped = TRUE)
# using the lambda to calculate PGLS
model.pgls <-pgls(V2~ V3, data = primate, lambda ='ML')
model.pgls1<-pgls(V2~ V4, data = primate, lambda ='ML')
model.pgls2<-pgls(V2~ V5, data = primate, lambda ='ML')
model.pgls3<-pgls(V2~ V3 + V4, data = primate, lambda ='ML')
model.pgls4<-pgls(V2~ V3 + V5, data = primate, lambda ='ML')
summary(model.pgls)
summary(model.pgls1)
summary(model.pgls2)
summary(model.pgls3)
summary(model.pgls4)

