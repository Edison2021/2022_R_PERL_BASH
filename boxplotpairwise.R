#http://www.sthda.com/english/articles/32-r-graphics-essentials/132-plot-grouped-data-box-plot-bar-plot-and-more/
library(dplyr) 
library(ggplot2)
library(ggpubr)
data("ToothGrowth")
# Box plot facetted by "dose"
p <- ggpaired(ToothGrowth, x = "supp", y = "len", color = "supp", palette = "jco",  line.color = "gray", line.size = 0.4, facet.by = "dose", short.panel.labs = FALSE)
# Use only p.format as label. Remove method name.
p + stat_compare_means(label = "p.format", paired = TRUE)
p + stat_compare_means(label = "p.format", paired = TRUE, methods="")

#format is very important and the order is very important, R can not automatcillay recinizie the type
#right one
26.7	VC	2
21.5	VC	2
23.3	VC	2
29.5	VC	2
15.2	OJ	0.5
21.5	OJ	0.5
17.6	OJ	0.5
9.7	OJ	0.5
14.5	OJ	0.5
#you can not mix bad one
26.7    VC      2
15.2    OJ      0.5
29.5    VC      2
21.5    OJ      0.5
 
