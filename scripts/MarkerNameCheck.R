MarkerNameCheck <- function(input, marker="MARKERNAME", chr="CHROMOSOME", pos="POSITION",markercheck=TRUE) {
# For Meta-analysis, check if have geniune markername, chr and pos
# valid chr must between 1 and 22
# valine pos much >0
# markername must contain valid chr and poss
# for example, 0:0:A:T is invalid
input[[chr]] <- as.numeric(input[[chr]])
input[[pos]] <-	as.numeric(input[[pos]])
check_chr_2 <- (!is.na(input[[chr]])) & input[[chr]]>0 & input[[chr]]<23
check_pos_2 <- (!is.na(input[[pos]])) & input[[pos]]>0
if (!markercheck) {
check_pass <- check_pos_2 & check_chr_2
} else {
input <- separate(input,"MARKERNAME",c("chr.new","pos.new","a1.new","a2.new"),sep=":")
input$chr.new <- as.numeric(input$chr.new)
input$pos.new <- as.numeric(input$pos.new)
ba <- c("A","C","G","T")
check_chr_1 <- (!is.na(input[["chr.new"]])) & input[["chr.new"]]>0 & input[["chr.new"]]<23
check_pos_1 <- (!is.na(input[["pos.new"]])) & input[["pos.new"]]>0
check_a1 <- (!is.na(input[["a1.new"]])) & (input[["a1.new"]] %in% ba)
check_a2 <- (!is.na(input[["a2.new"]])) & (input[["a2.new"]] %in% ba)
check_pass <- check_chr_1 & check_chr_2 & check_pos_1 & check_pos_2 & check_a1 & check_a2
}
return(check_pass)
}




