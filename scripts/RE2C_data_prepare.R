args<-commandArgs(trailingOnly=TRUE)
in_file_name <- args[1]
out_file_name <- args[2]

# Reformat sumstats, prepared for MR-MEGA, to RE2C format

library(data.table)
l <- readLines(in_file_name)
t1 <- Sys.time()
message("Work started at: ",t1)
message("The total number for files to be processed is: ",length(l))
for (i in 1:length(l)) {
  message("==========")
  message("Start processing file ",i)
  f <- fread(l[i])
  f <- f[,c("MARKERNAME","EA","NEA","BETA","SE")]
  f$BETA_flipped <- ifelse(f$EA < f$NEA, f$BETA, -f$BETA)
  f <- f[,c("MARKERNAME","BETA_flipped","SE")]
  names(f)[2:3] <- paste0(c("BETA_","SE_"),i)
  if (i == 1) {
    df_o <- f
  } else {df_o <- merge(df_o,f,all.x=T,all.y=T)
  }
  
  message("The number of markers for the ",i,"th file is: ",nrow(f))
  rm(f)
  message("The merged data frame have: ",nrow(df_o)," rows.")  
  message("Complete preparation for file ",i," successfully")
  message("==========")
}
message("The current data frame has ",nrow(df_o)," rows and ", ncol(df_o)," columns")
message("Remove markers present in less than two cohorts:")
df_o$na_count <- apply(df_o[,2:ncol(df_o)], 1, function(x) sum(!is.na(x)))
df_o <- df_o[df_o$na_count >=4, ]
df_o <- df_o[,!"na_count"]
message("The final data frame has ",nrow(df_o)," rows and ", ncol(df_o)," columns")
write.table(df_o,out_file_name,sep="\t",row.names=F,col.names=F,quote=F)
t2 <- Sys.time()
message("Work terminated at: ", t2)
diff_t <- difftime(t2, t1, units='mins')
message("Total time usage is: ", round(diff_t,1)," minutes.")

