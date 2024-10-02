library(ggplot2)
library(tidyverse)
data=read.csv('antisimmetry.tsv',sep='\t')
colnames(data)=c('Predictor','PCC f-r','X.δ.','Error')
base=ggplot(data=data, aes(x=`PCC f-r`, y=Predictor))
graph=base+geom_bar(stat="identity",fill="steelblue")
rez=graph+geom_text(aes(label=X.δ.,hjust=-2.5),position=position_dodge(0.75),size=2.95,angle = 90)+geom_text(aes(label=`PCC f-r`,vjust=1.5),position=position_dodge(0.75),size=2.65)+coord_flip()
rez1=rez+scale_y_discrete(position = 'right')+scale_x_continuous(n.breaks=10, limits=c(min(data$`PCC f-r`)-0.05,0), expand = c(0, 0))+theme_minimal()
antisimmetry=rez1+theme(axis.line = element_line(color="black", size = 1),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),plot.background = element_rect(colour = "white"),,axis.text.y = element_text(size=12),axis.text.x = element_text(face="bold",angle = 90,size=12,hjust=0.05), axis.title.y = element_text(face="bold",size=12),axis.title.x=element_blank())
antisimmetry

ggsave("antisimmetry.png",plot=antisimmetry,width=5735,height=5010,units='px',dpi=700)