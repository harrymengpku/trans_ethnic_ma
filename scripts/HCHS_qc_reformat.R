# QC and Reformatting for HCHS data
setwd("/SAN/ugi/mdd/sumstats/HCHS_SOL_binary")
library(data.table)
list_of_files <- list.files(path = "/SAN/ugi/mdd/sumstats/HCHS_SOL_binary", recursive = TRUE,
                            pattern = "\\.txt.gz$", 
                            full.names = TRUE)

# Read all the files and create a FileName column to store filenames
DT <- rbindlist(sapply(list_of_files, fread, simplify = FALSE),
                use.names = TRUE)

DT$BETA <- DT$score/DT$variance
DT$SE <- sqrt(DT$variance)/DT$variance

# flip strand
table(DT$strand)
# all variants on forward, no need to flip

# filter on info, effN,	insertions/deletions, and NAs for beta/se
check1 <- DT$info >= 0.7
check2 <- DT$effN >= 50
#check3 <- DT$HWE.pval >= 1e-5, not used, since 95% of variants have NA HWE P values.
ba <- c("A","C","G","T")
check3 <- DT$coded_allele %in% ba
check4 <- DT$other_allele %in% ba

qc <- check1 & check2 & check3 & check4
check <- DT[qc,]
rm(DT)

check$OR <- exp(check$BETA)
check$OR_95L <- exp(check$BETA-1.96*check$SE)
check$OR_95U <- exp(check$BETA+1.96*check$SE)

check5 <- check$oevar >= 0.7 # to be conservative, also QC on oevar
check <- check[check5,]

source("/SAN/ugi/mdd/trans_ethnic_ma/scripts/addNewId.R")
source("/SAN/ugi/mdd/trans_ethnic_ma/scripts/findDuplicate.R")

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
#[1] 84739838        7

check$newid <- addNewId(check,chr="chromosome",pos="position",A1="coded_allele",A2="other_allele")
names(DT) = paste0("DT_",names(DT))
check <- merge(check,DT,by.x="newid",by.y="DT_ID",all.x=TRUE,all.y=FALSE,sort=F)
check <- check[!is.na(check$DT_chr),]
cols <- c("newid","DT_rsid","DT_chr","DT_pos","coded_allele","other_allele","coded_allele_frequency","BETA","SE","pval","OR","OR_95L","OR_95U")
df <- check[,..cols]
Ncase <- 3979
Ncontrol <- 6499
df$N <- 4/(1/Ncase+1/Ncontrol)
names(df) <- c("MARKERNAME","RSID","CHROMOSOME","POSITION","EA","NEA","EAF","BETA","SE","P","OR","OR_95L","OR_95U","N")
write.table(df, "/SAN/ugi/mdd/trans_ethnic_ma/data/his_hchs_reformatted.txt",row.names=F,sep="\t",quote=F)

# remove duplicates
df <- fread("/SAN/ugi/mdd/trans_ethnic_ma/data/his_hchs_reformatted.txt.gz")
length(unique(df$MARKERNAME)) == nrow(df)
i <- findDuplicate(df$MARKERNAME)
df[i,]
df <- df[-i[2],]
length(unique(df$MARKERNAME)) == nrow(df)
j <- findDuplicate(df$RSID)
df[j,]
# there are around 40 duplicated rsids, some of which seems very odd, some rsid at different pos.
# need to be removed in the future, when remove multialleleic variants for all cohorts.
write.table(df, "/SAN/ugi/mdd/trans_ethnic_ma/data/his_hchs_reformatted.txt",row.names=F,sep="\t",quote=F)
