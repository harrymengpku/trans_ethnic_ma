args<-commandArgs(trailingOnly=TRUE)
input = args[1]
output = args[2]

#find and write out gwas significant locus according to MA results
print("find and write out gwas significant locus according to	MA results")

library(data.table)
ma <- fread(input,header=TRUE)
print(paste0("Dim for the input dataframe: ",dim(ma)))

# GWAS significant hits
gw <- subset(ma, P.value < 0.00000005)
print(paste0("Number of gwas significant hits: ", dim(gw)))

# Sort by chr and pos
gw <- gw[order(gw$chr,gw$pos),]

write.table(gw,output, sep="\t", row.names=FALSE, col.names=TRUE, quote = FALSE)

