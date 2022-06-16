#http://www.sthda.com/english/articles/32-r-graphics-essentials/132-plot-grouped-data-box-plot-bar-plot-and-more/
library(dplyr) 
library(ggplot2)
library(ggpubr)
data("ToothGrowth")
# Box plot facetted by "dose"
p <- ggpaired(ToothGrowth, x = "supp", y = "len", color = "supp", palette = "jco",  line.color = "gray", line.size = 0.4, facet.by = "dose", short.panel.labs = FALSE)+ facet_wrap(~group)
# Use only p.format as label. Remove method name.
p + stat_compare_means(label = "p.format", paired = TRUE)
p + stat_compare_means(label = "p.format", paired = TRUE, methods="")

#format is very important and the order is very important, R can not automatcillay recinizie the type
#right one
26.7	VC	2 group1
21.5	VC	2 group1
15.2	OJ	0.5 group2
21.5	OJ	0.5 group2
#you can not mix bad one
26.7    VC      2
15.2    OJ      0.5
29.5    VC      2
21.5    OJ      0.5
 
