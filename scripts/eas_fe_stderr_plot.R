#plotting the eas fix-effect results
library(data.table)
df <- fread("/SAN/ugi/mdd/trans_ethnic_ma/results/FE_eas_qced.txt")
#manhattan plot
dat <- df[!is.na(df$Chromosome)&!is.na(df$Position)&!is.na(df$P),]
library(qqman)
png("/SAN/ugi/mdd/trans_ethnic_ma/results/fe.eas.stderr.manhattan.png",w=2300, h=1200, pointsize=20)
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

png("/SAN/ugi/mdd/trans_ethnic_ma/results/fe.eas.stderr.qqplot.png",width=600,height=600)
qqPlot(df$P)
dev.off()

