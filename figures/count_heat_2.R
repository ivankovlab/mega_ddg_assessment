library(pheatmap)
library(tidyverse)
library(ggplot2)
library(grid)
data=read.table(file = 'count_heatmap.tsv', sep = '\t', header = TRUE)
df = data %>% column_to_rownames(., var = 'X')

col_func=function(x){
  if (x>382){
    'black'
  }
  else {
    'white'
  }
}
col_df=apply(df,c(1,2),col_func)

setHook("grid.newpage", function() pushViewport(viewport(x=1,y=1,width=0.9, height=0.9, name="vp", just=c("right","top"))), action="prepend")
pheatmap(df,cluster_cols = FALSE,cluster_rows = FALSE, display_numbers = TRUE, number_format = '%.0f', angle_col = 0, color = hcl.colors(800, "Inferno"),number_color = col_df)
setHook("grid.newpage", NULL, "replace")
grid.text('Wild type amino acid', y=-0.07, gp=gpar(fontsize=14))
grid.text('Mutant amino acid', x=-0.07, rot=90, gp=gpar(fontsize=14))
plot=grid.grab()

ggsave('count_heatmap.png', plot=plot, width = 6756, height = 5383, units = "px",dpi=700)

