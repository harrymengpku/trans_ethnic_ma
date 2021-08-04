library(data.table)
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

