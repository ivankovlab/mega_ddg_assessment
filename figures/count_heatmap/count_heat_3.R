library(ComplexHeatmap)
library(tidyverse)
library(ggplot2)
library(grid)
data=read.table(file = 'count_heatmap.tsv', sep = '\t', header = TRUE)
df = data %>% column_to_rownames(., var = 'X')

df=t(df)
plot=Heatmap(df,
             column_title_side = "bottom",
             column_names_rot = 0,
             cluster_rows = FALSE,
             cluster_columns = FALSE,
             row_names_side = 'left',
             col = hcl.colors(800, "Inferno"),
             row_title = 'Wild type amino acid',
             column_title = 'Mutant type amino acid',
             cell_fun = function(j, i, x, y, width, height, fill) {text_color <- ifelse(df[i, j] > 400, "black", "white");grid.text(sprintf("%.0f", df[i, j]), x, y, gp = gpar(col=text_color,fontsize = 8))},
             heatmap_legend_param = list(
               title = NULL,
               title_gp = gpar(fontsize = 14),
               labels_gp = gpar(fontsize = 12),
               legend_height = unit(15, "cm")
             ))
plot=as.ggplot(plot)

ggsave('count_heatmap2.png', plot=plot, width = 6756, height = 5383, units = "px",dpi=700)

