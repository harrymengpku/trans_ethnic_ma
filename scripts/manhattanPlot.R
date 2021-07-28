args <- commandArgs(trailingOnly=TRUE)
file <- args[1]
out <- args[2]

library(data.table)
library(ggplot2)
library(qqman)

check <- fread(file,header=T)
dat<-check[which(!is.na(check$CHROMOSOME) & !is.na(check$POSITION) & !is.na(check$P)),]
png(out,type="cairo",w=2300, h=1200)
manhattan(dat,snp="MARKERNAME",chr="CHROMOSOME",bp="POSITION",p="P",cex=0.01)
dev.off()
