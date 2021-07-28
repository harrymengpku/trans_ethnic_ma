library(data.table)
# read mr_mega result
mr_mega <- fread("/SAN/ugi/mdd/trans_ethnic_ma/results/AFR.EAS.SAS.HIS.MDD3SUM.MRMEGA.result.gz")
# read eur mdd3 result
mdd3 <- fread("/SAN/ugi/mdd/trans_ethnic_ma/data/eur_mdd3_reformatted.txt.gz")
list_of_files <- list.files(path = "/SAN/ugi/ukhls/1000G/1KGP3_bim", recursive = TRUE,
                            pattern = "\\.bim.gz$", 
                            full.names = TRUE)

# Read all the files and create a FileName column to store filenames
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

mr_mega <- mr_mega[!is.na(mr_mega$'P-value_association'),c("MarkerName","Chromosome","Position","EA","NEA","EAF","Nsample","beta_0","se_0","P-value_association")]
names(mr_mega) <- c("MarkerName","Chromosome","Position","EA","NEA","EAF","N","BETA","SE","P")
names(mr_mega) <- paste0(names(mr_mega),"_1")

mdd3 <- mdd3[,c("MARKERNAME","CHROMOSOME","POSITION","EA","NEA","EAF","BETA","SE","P","N")]
names(mdd3) <- c("MarkerName","Chromosome","Position","EA","NEA","EAF","BETA","SE","P","N")
names(mdd3) <- paste0(names(mdd3),"_2")

f <- merge(mr_mega,mdd3,by.x="MarkerName_1",by.y="MarkerName_2",all.x=T,all.y=T)
f <- merge(f,DT,by.x="MarkerName_1",by.y="ID_1KG",all.x=T,all.y=F)

f$source <- ifelse(is.na(f$P_1), "2", ifelse(is.na(f$P_2),"1",ifelse(f$P_1<f$P_2,"1",ifelse(f$P_1>=f$P_2,"2","problem"))))
f$Chromosome <- ifelse(f$source == "1",f$Chromosome_1, ifelse(f$source == "2", f$Chromosome_2,"problem"))
f$Position <- ifelse(f$source == "1",f$Position_1, ifelse(f$source == "2", f$Position_2,"problem"))
f$EA <- ifelse(f$source == "1",f$EA_1, ifelse(f$source == "2", f$EA_2,"problem"))
f$NEA <- ifelse(f$source == "1",f$NEA_1, ifelse(f$source == "2", f$NEA_2,"problem"))
f$EAF <- ifelse(f$source == "1",f$EAF_1, ifelse(f$source == "2", f$EAF_2,"problem"))
f$BETA <- ifelse(f$source == "1",f$BETA_1, ifelse(f$source == "2", f$BETA_2,"problem"))
f$SE <- ifelse(f$source == "1",f$SE_1, ifelse(f$source == "2", f$SE_2,"problem"))
f$P <- ifelse(f$source == "1",f$P_1, ifelse(f$source == "2", f$P_2,"problem"))
f$N <- ifelse(f$source == "1",f$N_1, ifelse(f$source == "2", f$N_2,"problem"))
f$BETA <- as.numeric(f$BETA)
f$OR <- exp(f$BETA)

cols <- c("MarkerName_1","rsid_1KG","Chromosome","Position","EA","NEA","EAF","OR","BETA","SE","P","N","source")
f <- f[,..cols]
names(f)[1:2] = c("MarkerName","RSID")
f <- f[order(f$Chromosome,f$Position),]

write.table(f,"/SAN/ugi/mdd/trans_ethnic_ma/results/mr_mega_result_qced.txt",row.names=F,col.names=T,quote=F,sep="\t")
f_annotation <- f[f$P<0.05,]
write.table(f_annotation,"/SAN/ugi/mdd/trans_ethnic_ma/results/mr_mega_result_qced_annotation.txt",row.names=F,col.names=T,quote=F,sep="\t")
#f <- transform(f, min = pmin(V2, V3,V4,V5,V6,V7,V8,V9,na.rm=T))

#library("GenABEL")
#estlambda(check$P.value,proportion=0.95)
#Ncases=
#Ncontrols=
#lambda1000
#lambda = estlambda$estimate
#lambda1000 <- 1 + 500*(lambda-1)*(1/Ncases+1/Ncontrols)
#lambda1000


