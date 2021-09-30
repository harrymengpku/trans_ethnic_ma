# QC for fixed effect MA implemented by METAL, 

setwd("/SAN/ugi/mdd/trans_ethnic_ma/results/")
library(data.table)
df <- fread("/SAN/ugi/mdd/trans_ethnic_ma/results/FE_lat_qced.txt",header=T)


#manhattan plot
dat <- df[!is.na(df$Chromosome)&!is.na(df$Position)&!is.na(df$P),]
library(qqman)
png("/SAN/ugi/mdd/trans_ethnic_ma/results/fe.his.stderr.manhattan.png",w=2300, h=1200, pointsize=20)
manhattan(dat,snp="RSID",chr="Chromosome",bp="Position",p="P",col = c("navyblue","red4"))
dev.off()
