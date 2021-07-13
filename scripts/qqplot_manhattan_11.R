library(data.table)
check<-fread("/SAN/ugi/mdd/african_ma/results/whix2.ukb.biome.army.drakenstein.ihs.23andme.jhs.biovu.mvp.qced.210521.rsids.neff.stderr.with.chr.pos.txt",header=TRUE)
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
png("/SAN/ugi/mdd/african_ma/exploratory/whix2.ukb.biome.army.drakenstein.ihs.23andme.jhs.biovu.mvp.qced.210521.rsids.neff.stderr.qqplot.png",width=600,height=600)
qqPlot(check$P.value)
dev.off()

library(qqman)
dat<-check[which(!is.na(check$chr) & !is.na(check$pos) & !is.na(check$P.value)),]
png("/SAN/ugi/mdd/african_ma/exploratory/whix2.ukb.biome.army.drakenstein.ihs.23andme.jhs.biovu.mvp.qced.210521.rsids.neff.stderr.manhattan.png",w=2300, h=1200, pointsize=20)
manhattan(dat,snp="MarkerName",chr="chr",bp="pos",p="P.value",highlight = c("rs73650303","rs6902879"))
dev.off()

q()
n
