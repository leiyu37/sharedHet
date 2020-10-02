#!/usr/bin/env Rscript
library(ggplot2)
obj <- read.table("01_sharedHet.txt", header = TRUE)

pdf("plot.pdf", width = 4, height = 4)
ggplot(obj, aes(Fa, Fb)) +
  geom_vline(xintercept = 0.95, color = "orange", linetype = "dashed") +
  geom_hline(yintercept = 0.95, color = "orange", linetype = "dashed") +
  geom_point(size=0.3) +
  scale_x_continuous(breaks = c(0,0.25,0.5,0.75,0.95), limits = c(0,1)) +
  scale_y_continuous(breaks = c(0,0.25,0.5,0.75,0.95), limits = c(0,1)) +
  theme_classic()
dev.off()
