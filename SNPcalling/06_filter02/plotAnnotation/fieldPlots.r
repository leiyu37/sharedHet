#!/usr/bin/env Rscript
library(ggplot2)
snp <- read.table("Rtable_peach.txt", header = TRUE)


pdf("peach20200929_QD.pdf",width=6,height=4,paper='special')
ggplot(snp, aes(x=QD)) + geom_density()
dev.off()

pdf("peach20200929_FS.pdf",width=6,height=4,paper='special')
ggplot(snp, aes(x=FS)) + geom_density() + scale_x_continuous(trans='log10') + geom_vline(xintercept = 15)
dev.off()


pdf("peach20200929_SOR.pdf",width=6,height=4,paper='special')
ggplot(snp, aes(x=SOR)) + geom_density() + xlim(0,10)
dev.off()

pdf("peach20200929_MQ.pdf",width=6,height=4,paper='special')
ggplot(snp, aes(x=MQ)) + geom_density() + xlim(0,70)
dev.off()

pdf("peach20200929_MQRankSum.pdf",width=6,height=4,paper='special')
ggplot(snp, aes(x=MQRankSum)) + geom_density() + xlim(-11,6)
dev.off()

pdf("peach20200929_ReadPosRankSum.pdf",width=6,height=4,paper='special')
ggplot(snp, aes(x=ReadPosRankSum)) + geom_density() + xlim(-5,5)
dev.off()

pdf("peach20200929_DP.pdf",width=6,height=4,paper='special')
ggplot(snp, aes(x=DP)) + geom_histogram(binwidth = 10) + xlim(0,2500) + geom_vline(xintercept = 1080)
dev.off()

mean(snp$DP) * 2
