args <- commandArgs(trailingOnly=TRUE)
FileIn <- args[1]
FileOut <- args[2]

#mdd3 sumstats test
library(data.table)
options(scipen = 999) # disable scientific notation
source("/home/xmeng/trans_ethnic_ma/scripts/MarkerNameCheck.R")
source("/home/xmeng/trans_ethnic_ma/scripts/addNewId.R")
bialle_1000G <- fread("/home/xmeng/trans_ethnic_ma/data/1000G.biallelic.ALLchr.snplist.txt.gz") # keep only bi-allelic and indels
dim(bialle_1000G)
head(bialle_1000G)
df <- fread(FileIn)
dim(df)
head(df)
table(df$CHR)
table(df$A1)
table(df$A2)
i <- grep("FRQ_A",names(df))
i
names(df)[i]
j <- grep("FRQ_U",names(df))
j
names(df)[j]
Nca <- substr(names(df)[i],7,nchar(names(df)[i]))
Nca <- as.numeric(Nca)
Nca
Ncon <- substr(names(df)[j],7,nchar(names(df)[j]))
Ncon <- as.numeric(Ncon)
Ncon
df$FRQ <- (df[[i]]*Nca + df[[j]]*Ncon)/(Nca+Ncon)
df$N <- Nca + Ncon
df$Neff <- 4/(1/Nca+1/Ncon)
df$newid <- addNewId(df,chr="CHR",pos="BP",A1="A1",A2="A2")
df$newA1 <- addNewA1(df,A1="A1",A2="A2")
df$newA2 <- addNewA2(df,A1="A1",A2="A2")
df$BETA <- log(df$OR)
df$OR_95L <- exp(df$BETA - 1.96*df$SE)
df$OR_95U <- exp(df$BETA + 1.96*df$SE)
# for qc purpose, check INFO and FRQ
df <- df[!is.na(df$INFO),]
df <- df[!is.na(df$FRQ),]
dim(df)
summary(df$INFO)
summary(df$FRQ)

df$effN<-2*df$FRQ*(1-df$FRQ)*df$N*df$INFO  
summary(df$effN)

if(sum(df$FRQ<0.7)!=0) {
  sum(df$FRQ<0.7)
  df <- df[df$FRQ>=0.7,]
  dim(df)
}

if(sum(df$effN<50)!=0|sum(df$FRQ<0.005|df$FRQ>0.995)!=0){
  sum(df$effN<50|df$FRQ<0.005|df$FRQ>0.995)
  df <- df[!(df$effN<50|df$FRQ<0.005|df$FRQ>0.995),]
  dim(df)
}

sum(df$FRQ<0.7)==0
sum(df$effN<50)==0 & sum(df$FRQ<0.005|df$FRQ>0.995)==0
head(df)

output <- df[,c("newid","SNP","CHR","BP","newA1","newA2","FRQ","BETA","SE","P","OR","OR_95L","OR_95U","Neff")]
names(output) <- c("MARKERNAME","RSID","CHROMOSOME","POSITION","EA","NEA","EAF","BETA","SE","P","OR","OR_95L","OR_95U","N")

# check whether with valid chr and pos
check <- MarkerNameCheck(output)
sum(check)
sum(!check)
head(output[!check,])
output <- output[check,]

# check whether all biallelic or indels
check <- output$MARKERNAME %in% bialle_1000G$MARKERNAME | (output$EA %in% c("I","D")|output$NEA %in% c("I","D"))
sum(check)
sum(!check)
head(output[!check,])
output <- output[check,]

output <- output[order(output$CHROMOSOME,output$POSITION),]
length(unique(output$MARKERNAME)) == nrow(output)

# delete dupliated markernames
if (length(unique(output$MARKERNAME)) != nrow(output)) {
  n_occur <- data.frame(table(output$MARKERNAME))
  length(n_occur$Var1[n_occur$Freq>1])
  table(n_occur$Freq[n_occur$Freq>1])
  head(output[output$MARKERNAME %in% n_occur$Var1[n_occur$Freq>1],])
  
  output <- output[!output$MARKERNAME %in% n_occur$Var1[n_occur$Freq>1],]
  length(unique(output$MARKERNAME)) == nrow(output)
}

dim(output)
head(output)

write.table(output, FileOut,row.names=F,sep="\t",quote=F) 




