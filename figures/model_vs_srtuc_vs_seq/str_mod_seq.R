library(ggplot2)
library(tidyverse)
colors=c('#ef767a','#456990','#49BEAA')

data=read.csv('str_mod_seq.tsv',sep='\t')
base=ggplot(data=data, aes(x=PCC, y=Predictor, fill=Type))
graph=base+geom_bar(width=0.75,stat="identity", position=position_dodge(0.75))
rez=graph+geom_text(aes(label=Count,x=0.08),position=position_dodge(0.75),size=2.95,angle = 90)+geom_text(aes(label=PCC,vjust=-1),position=position_dodge(0.75),size=2.65)+coord_flip()
rez1=rez+ scale_fill_manual(values=colors)+theme_minimal()+scale_x_continuous(n.breaks=10,limits = c(0, 1), expand = c(0, 0))
rsa=rez1+theme(axis.line = element_line(color="black", size = 1),panel.grid.major = element_blank(), panel.grid.minor = element_blank(),plot.background = element_rect(colour = "white"),axis.text.y = element_text(size=12),axis.text.x = element_text(face="bold",angle = 90,size=12,hjust=0.95,vjust=0.2), axis.title.y = element_text(face="bold",size=12),axis.title.x=element_blank())
rsa

ggsave("str_mod_seq1.png",plot=rsa,width=5735,height=4510,units='px',dpi=700)