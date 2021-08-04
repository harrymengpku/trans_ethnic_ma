# QC for fixed effect MA implemented by METAL, 

setwd("/SAN/ugi/mdd/trans_ethnic_ma/results/")
library(data.table)
df <- fread("METAANALYSIS_FE_1.tbl")

# Read 1000G all bim files and create a FileName column to store filenames
list_of_files <- list.files(path = "/SAN/ugi/ukhls/1000G/1KGP3_bim", recursive = TRUE,
                            pattern = "\\.bim.gz$", 
                            full.names = TRUE)

DT <- rbindlist(sapply(list_of_files, fread, simplify = FALSE),
                use.names = TRUE)

head(DT)
#   chr        rsid cm   pos A1 A2           ID
#1:   1 rs367896724  0 10177 AC  A 1:10177:AC:A
#2:   1 rs540431307  0 10235 TA  T 1:10235:TA:T
#3:   1 rs555500075  0 10352 TA  T 1:10352:TA:T
#4:   1 rs548419688  0 10505  T  A  1:10505:A:T
#5:   1 rs568405545  0 10506  G  C  1:10506:C:G
#6:   1 rs534229142  0 10511  A  G  1:10511:A:G

dim(DT)
names(DT) <- paste0(names(DT),"_1KG")

df$N_study <- rowSums(t(data.frame(strsplit(df$Direction,split="")))!="?")
summary(df$HetIsq)
heter <- subset(ma, HetISq<75)
dim(heter)
df <- merge(df,DT,by.x="MarkerName",by.y="ID",all.x=T,all.y=F)
cols <- c("MarkerName","rsid","chr","pos","Allele1","Allele2","Freq1","Effect","StdErr","P-value","N_study")
df <- df[,..cols]

names(df) <- c("MarkerName","RSID","Chromosome","Position","EA","NEA","EAF","BETA","SE","P","N_study")
df <- df[df$N_study>1,]
df <- df[order(df$Chromosome,df$Position),]
dim(df)
write.table(df,"/SAN/ugi/mdd/trans_ethnic_ma/results/METAANALYSIS_FE_qced.txt", sep="\t", row.names=FALSE, col.names=TRUE, quote = FALSE)

f_annotation <- df[df$P<0.05,]
write.table(f_annotation,"/SAN/ugi/mdd/trans_ethnic_ma/results/METAANALYSIS_FE_qced_annotation.txt",row.names=F,col.names=T,quote=F,sep="\t")
