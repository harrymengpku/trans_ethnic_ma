args <- commandArgs(trailingOnly=TRUE)
file <- args[1]
out <- args[2]

library(data.table)

data = fread(file,header=T)
png(out,type="cairo",width=600,height=600)
obspval <- sort(data$P)
logobspval <- -(log10(obspval))
exppval <- c(1:length(obspval))
logexppval <- -(log10( (exppval-0.5)/length(exppval)))
obsmax <- trunc(max(logobspval))+1
expmax <- trunc(max(logexppval))+1
plot(c(0,expmax), c(0,expmax), col="gray", lwd=1, type="l", xlab="Expected -log10 P-value", ylab="Observed -log10 P-value", xlim=c(0,expmax), ylim=c(0,obsmax), las=1, xaxs="i", yaxs="i", bty="l")
points(logexppval, logobspval, pch=23, cex=.4, bg="black")
beta <- data$BETA
se <- data$SE
z<-(beta/se)*(beta/se)
lambda<-median(z[complete.cases(z)])/0.456
text=paste("Lambda is", lambda, sep=" ")
print(text)
dev.off()





