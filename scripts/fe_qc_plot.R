args <- commandArgs(trailingOnly=TRUE)
file <- args[1]
out <- args[2]

# QC for fixed effect MA implemented by METAL, 
library(data.table)
library(tidyr)
df <- fread(file)

summary(df$HetIsq)
heter <- subset(df, HetISq<75)
dim(heter)

df <- separate(data = df, col = "MarkerName", into = c("chr", "pos","A1","A2"), sep = ":",remove=F)
df$N_study <- df$HetDf+1
cols <- c("MarkerName","chr","pos","Allele1","Allele2","Freq1","Effect","StdErr","P-value","N_study","Direction","HetISq","HetPVal")
df <- df[,..cols]

names(df) <- c("MarkerName","Chromosome","Position","EA","NEA","EAF","BETA","SE","P","N_study","Direction","HetISq","HetPVal")
df <- df[df$N_study>1,]
df <- df[order(df$Chromosome,df$Position),]
dim(df)
write.table(df,paste0(out,".txt"), sep="\t", row.names=FALSE, col.names=TRUE, quote = FALSE)

gw <- df[df$P<5e-8,]
dim(gw)
gw
write.table(gw,paste0(out,"_sig.txt"),sep="\t",row.names=FALSE, col.names=TRUE,quote=F)

#manhattan plot
dat <- df[!is.na(df$Chromosome)&!is.na(df$Position)&!is.na(df$P),]
library(qqman)
png(paste0(out,".manhattan.png"),w=2300, h=1200, pointsize=20)
manhattan(dat,chr="Chromosome",bp="Position",p="P",col = c("navyblue","red4"))
dev.off()

#qqplot

library(ggplot2)
qqPlot <- function(pval) {
    pval <- pval[!is.na(pval)]
    n <- length(pval)
    x <- 1:n
    dat <- data.frame(obs=sort(pval),
                      exp=x/n,
                      upper=qbeta(0.025, x, rev(x)),
                      lower=qbeta(0.975, x, rev(x)))
    
    ggplot(dat, aes(-log10(exp), -log10(obs))) +
        geom_line(aes(-log10(exp), -log10(upper)), color="gray") +
        geom_line(aes(-log10(exp), -log10(lower)), color="gray") +
        geom_point() +
        geom_abline(intercept=0, slope=1, color="red") +
        xlab(expression(paste(-log[10], "(expected P)"))) +
        ylab(expression(paste(-log[10], "(observed P)"))) +
        theme_bw()
}    

png(paste0(out,".qqplot.png"),width=600,height=600)
qqPlot(df$P)
dev.off()

library("GenABEL")
estlambda(df$P,proportion=0.95)
