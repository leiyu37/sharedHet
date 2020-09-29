#!/bin/bash


gatk --java-options "-Xmx96G" VariantsToTable \
   -R Prunus_persica_v2.0.a1_scaffolds.fasta \
   -V 02_select_snp.vcf \
   -O Rtable_peach.txt \
   -F CHROM -F POS -F FILTER -F QD -F MQ -F FS -F SOR -F MQRankSum -F ReadPosRankSum -F DP
