findDuplicate <- function(i) {
# find duplicates in a vector and return indice values
n_occur <- data.frame(table(i))
index = which(i %in% n_occur$i[n_occur$Freq > 1])
return(index)
}
