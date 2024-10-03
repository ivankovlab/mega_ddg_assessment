library(pheatmap)
library(tidyverse)
library(ggplot2)
data=read.table(file = 'for_heatmap_per prot.tsv', sep = '\t', header = TRUE)
df = data%>% select(-ddg_thermonet_pdb) %>% column_to_rownames(., var = 'protein')
colnames(df)=c("ESM","ACDC NN 3D","ACDC NN sequence","DDGun 3D","DDGun sequence","DDMut","Eris","FoldX","INPS 3D","INPS sequence","Rosetta" )
amount_data=read.table(file = 'for_heatmap_per prot_amount.tsv', sep = '\t', header = TRUE)
amount_df = amount_data%>% select(-ddg_thermonet_pdb) %>% column_to_rownames(., var = 'protein')
colnames(amount_df)=c("ESM","ACDC NN 3D","ACDC NN sequence","DDGun 3D","DDGun sequence","DDMut","Eris","FoldX","INPS 3D","INPS sequence","Rosetta" )
df1=df%>%slice(1:75)
df2=df%>%slice(-c(1:75))
amount_df1=amount_df%>%slice(1:75)
amount_df2=amount_df%>%slice(-c(1:75))
col_func=function(x){
  if (is.na(x)){
    return("gray")
  }
  if (x>0.425){
    'black'
  }
  else {
    'white'
  }
}
df1=t(df1)
col_df1=apply(df1,c(1,2),col_func)
df2=t(df2)
col_df2=apply(df2,c(1,2),col_func)
amount_df1=t(amount_df1)
amount_df2=t(amount_df2)

plot1=pheatmap(df1,cluster_cols = FALSE,cluster_rows = FALSE,display_numbers = TRUE,gaps_row = c(1,3,5,6,7,8,10),angle_col = 90, color = hcl.colors(100, "Inferno"),number_color = col_df1,na_col = 'gray')
ggsave('heatmap_per_prot1.png',plot = plot1, width = 70, height = 10, units = "cm",dpi=1000,limitsize = FALSE)

plot2=pheatmap(df2,cluster_cols = FALSE,cluster_rows = FALSE,display_numbers = TRUE,gaps_row = c(1,3,5,6,7,8,10),angle_col = 90, color = hcl.colors(100, "Inferno"),number_color = col_df2,na_col = 'gray')
ggsave('heatmap_per_prot2.png',plot = plot2, width = 70, height = 10, units = "cm",dpi=1000,limitsize = FALSE)

plot3=pheatmap(df1,cluster_cols = FALSE,cluster_rows = FALSE,display_numbers = amount_df1,gaps_row = c(1,3,5,6,7,8,10),angle_col = 90, color = hcl.colors(100, "Inferno"),number_color = col_df1,na_col = 'gray')
ggsave('heatmap_per_prot1_amount.png',plot = plot3, width = 70, height = 10, units = "cm",dpi=1000,limitsize = FALSE)

plot4=pheatmap(df2,cluster_cols = FALSE,cluster_rows = FALSE,display_numbers = amount_df2,gaps_row = c(1,3,5,6,7,8,10),angle_col = 90, color = hcl.colors(100, "Inferno"),number_color = col_df2,na_col = 'gray')
ggsave('heatmap_per_prot2_amount.png',plot = plot4, width = 70, height = 10, units = "cm",dpi=1000,limitsize = FALSE)
