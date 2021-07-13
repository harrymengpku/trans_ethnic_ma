args<-commandArgs(trailingOnly=TRUE)
fname_ma <- args[1]
fname_out <- args [2]
w <- args[3]


##########
# Find best variant in a GWAS result, if mulitple variants in multiple locus came out to be significant
# fname_ma, gwas results as input
# fname_out, output file name
# w, window vaule used to define locus
# column names should be defined as, "chr","pos"
##########

library(data.table)
df <- fread(fname_ma)
df <- df[(!is.na(df$chr))&(!is.na(df$pos)),]
df <- df[order(df$chr,df$pos),]
window <- as.numeric(w)
# define variant chunks.
df$chunk = NA

for (j in 1:length(unique(df$chr))) {
  c = unique(df$chr)[j]
  m = 1
  for (i in 1:length(df$pos[df$chr==c])) {
    chunk = paste0(c,".",m)
    df$chunk[df$chr==c][i] = chunk
  if (i == length(df$pos[df$chr==c])) {print(paste0("Done for defining locus regions for chr",c))}
  else if ((df$pos[df$chr==c][i+1]-df$pos[df$chr==c][i]) > window) {
    m = m+1} else {}
  
}}

# find variant with lowest P within each chunk
df_clumped = data.frame()
for (i in 1:length(unique(df$chunk))) {
  d <- df[df$chunk == unique(df$chunk)[i],]
  d <- d[which(d$P.value == min(d$P.value)),]
  df_clumped = rbind(df_clumped,d)
}

df_clumped <- df_clumped[order(df_clumped$chr,df_clumped$pos),]
write.table(df_clumped,fname_out,row.names=F,quote=F,sep="\t")
write.table(df,paste0("all_variants_",fname_out),row.names=F,quote=F,sep="\t")

