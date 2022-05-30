# run as Rscript Growthcurve_blankA1_H.R 
## convert seconds to h /3600
##https://cran.r-project.org/web/packages/growthcurver/vignettes/Growthcurver-vignette.html
#!/usr/bin/Rscript
#preliminaries
library(growthcurver)
## change the file name each time
#  read the data
args = commandArgs(trailingOnly=TRUE)
d<-read.table(args[1],  header = TRUE, sep = "\t", stringsAsFactors = FALSE)
#d$time <- d$time / 60 / 60
# If you would like to use the "blank" background correction, then call Growthcurver as follows. must have the "blank" colunm
# If you would like to generate plots for all of the growth curves in your plate, then call Growthcurver as follows. You can change the name of the output file "gc_plots.pdf" to something that makes sense for you.
gc_out <- SummarizeGrowthByPlate(d,plot_fit = TRUE, plot_file = "gc_plots.pdf", bg_correct = "blank")
# The summary information for each well is listed as a row in the output data frame called gc_out.  You can save the entire data table to a tab-separated file that can be imported into Excel.
write.table(gc_out, file = args[2], quote = FALSE, sep = "\t", row.names = FALSE)
#####################input format###########################
# set one blank well
#time blank	B1	C1	D1	E1	F1	G1
#0.0000000	0.0534859	0.0450445	0.0524558	0.0559717	0.0555779	0.0482403	0.0480286
#0.1666667	0.0480034	0.0438943	0.0513760	0.0535398	0.0498355	0.0545188	0.0508498
#0.3333333	0.0558745	0.0499971	0.0471483	0.0490218	0.0547812	0.0508200	0.0461799
#0.5000000	0.0513175	0.0521323	0.0481636	0.0455630	0.0461267	0.0552204	0.0459967
#0.6666667	0.0451672	0.0471601	0.0474251	0.0515392	0.0528446	0.0529912	0.0462149
#0.8333333	0.0529321	0.0493626	0.0512493	0.0487991	0.0466157	0.0467418	0.0506130
