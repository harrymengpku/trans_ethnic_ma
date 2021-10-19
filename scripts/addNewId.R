# Add newID according to Olga's rule for file with SNP names

addNewId <- function (input,chr="chr",pos="pos",A1="A1",A2="A2") {
  # input as a data frame, with columns: chr, pos, A1 and A2
  # A newid column will be generated
  newid<-ifelse(nchar(input[[A1]])==1 & nchar(input[[A2]])==1 & input[[A1]] < input[[A2]],
                paste(input[[chr]], input[[pos]],input[[A1]],input[[A2]],sep=":"),
                ifelse(nchar(input[[A1]])==1 & nchar(input[[A2]])==1 & input[[A1]] > input[[A2]],
                       paste(input[[chr]],input[[pos]],input[[A2]],input[[A1]],sep=":"),
                       ifelse((nchar(input[[A1]])>1 | nchar(input[[A2]])>1) & nchar(input[[A1]]) != nchar(input[[A2]]),
                              paste(input[[chr]],input[[pos]],"D","I",sep=":"),
                              ifelse((nchar(input[[A1]])>1 | nchar(input[[A2]])>1) & nchar(input[[A1]]) == nchar(input[[A2]]),
                                     paste(input[[chr]],input[[pos]],"I","I",sep=":"),
                                     "problem"))))
  return(newid)
}

addNewA1 <- function(input,A1="A1",A2="A2") {
  newA1 <- ifelse(nchar(input[[A1]])==1 & nchar(input[[A2]])==1,
         input[[A1]],
         ifelse((nchar(input[[A1]])>1 | nchar(input[[A2]])>1) & nchar(input[[A1]]) < nchar(input[[A2]]),
         "D",
         ifelse((nchar(input[[A1]])>1 | nchar(input[[A2]])>1) & nchar(input[[A1]]) >= nchar(input[[A2]]),
         "I","problem")))
  return(newA1)
}

addNewA2 <- function(input,A1="A1",A2="A2") {
  newA2 <- ifelse(nchar(input[[A1]])==1 & nchar(input[[A2]])==1,
                  input[[A2]],
                  ifelse((nchar(input[[A1]])>1 | nchar(input[[A2]])>1) & nchar(input[[A2]]) < nchar(input[[A1]]),
                         "D",
                         ifelse((nchar(input[[A1]])>1 | nchar(input[[A2]])>1) & nchar(input[[A2]]) >= nchar(input[[A1]]),
                                "I","problem")))
  return(newA2)
}

addNewId3 <- function (input,p1="",A1="A1",A2="A2") {
  # input as a data frame, with columns: chr:pos/rsid, A1 and A2
  # A newid column will be generated
  newid<-ifelse(nchar(input[[A1]])==1 & nchar(input[[A2]])==1 & input[[A1]] < input[[A2]], 
                paste(input[[p1]],input[[A1]],input[[A2]],sep=":"),
                ifelse(nchar(input[[A1]])==1 & nchar(input[[A2]])==1 & input[[A1]] > input[[A2]], 
                       paste(input[[p1]],input[[A2]],input[[A1]],sep=":"),
                       ifelse((nchar(input[[A1]])>1 | nchar(input[[A2]])>1) & nchar(input[[A1]]) > nchar(input[[A2]]), 
                              paste(input[[p1]],input[[A1]],input[[A2]],sep=":"),
                              ifelse((nchar(input[[A1]])>1 | nchar(input[[A2]])>1) & nchar(input[[A1]]) < nchar(input[[A2]]), 
                                     paste(input[[p1]],input[[A2]],input[[A1]],sep=":"),"problem"))))
  return(newid)
}
