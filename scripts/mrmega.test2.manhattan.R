library(data.table)
library(ggplot2)
library(qqman)
check <- fread("/SAN/ugi/mdd/trans_ethnic_ma/results/mrmega.test2.result")
names(check)[2:3] <- c("chr","pos")
names(check)[20] <- "P.value" 
dat<-check[which(!is.na(check$chr) & !is.na(check$pos) & !is.na(check$P.value)),]
png("/SAN/ugi/mdd/trans_ethnic_ma/results/mrmega.test2.manhattan.png",w=2300, h=1200, pointsize=20)
manhattan(dat,snp="MarkerName",chr="chr",bp="pos",p="P.value")
dev.off()


