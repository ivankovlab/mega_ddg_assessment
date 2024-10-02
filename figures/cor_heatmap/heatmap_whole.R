library(pheatmap)
library(tidyverse)
library(ggplot2)
data=read.table(file = 'for_heatmap2(1).tsv', sep = '\t', header = TRUE)
row_names=c('Buried','Exposed','Charge change','No charge change','Hydrophobicity change','No hydrophobicity change','Polarity change','No polarity change','Large decrease in size','Slight decrease in size','No size change','Slight increase in size','Large increase in size','All')
#column_names=c('ESM','ACDC-NN 3D (AlphaFold)','ACDC-NN 3D (ESMFold)','ACDC-NN 3D','ACDC-NN sequence','DDGun 3D (AlphaFold)','DDGun 3D (ESMFold)','DDGun 3D','DDGun sequence','FoldX (AlphaFold)','FoldX (ESMFold)','FoldX','ThermoNet (AlphaFold)','Thermonet (ESMFold)','ThermoNet')
data$Types.within.property=row_names
df = data %>% column_to_rownames(., var = 'Types.within.property')
colnames(df)=c("ESM","ACDC NN 3D","ACDC NN sequence","DDGun 3D","DDGun sequence","DDMut","Eris","FoldX","INPS 3D","INPS sequence","Rosetta" )

col_func=function(x){
  if (x>0.4086282){
    'black'
  }
  else {
    'white'
  }
}
col_df=apply(df,c(1,2),col_func)

categ = data.frame('Mutation category' = rep(c('RSA','Charge','Hydrophobicity','Polarity','Size','All'),c(2,2,2,2,5,1)))
rownames(categ) = rownames(df)
colnames(categ)=c('Mutation category')

plot=pheatmap(df,cluster_cols = FALSE,cluster_rows = FALSE, annotation_row = categ,display_numbers = TRUE,gaps_row = c(2,4,6,8,13),gaps_col = c(1,3,5,6,7,8,10),angle_col = 90, color = hcl.colors(100, "Inferno"),number_color = col_df)


ggsave('heatmap2.png',plot = plot, width = 6756, height = 5383, units = "px",dpi=700)

