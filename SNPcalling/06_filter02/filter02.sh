#!/bin/bash

gatk --java-options "-Xmx96G" VariantFiltration \
   -R Prunus_persica_v2.0.a1_scaffolds.fasta \
   -V 02_select_snp.vcf \
   -O 03_markfilter_snp.vcf \
   --filter-expression "MQ < 40.0" \
   --filter-name "MQ_F" \
   --filter-expression "FS > 15.0" \
   --filter-name "FS_F" \
   --filter-expression "QD < 15.0" \
   --filter-name "QD_F" \
   --filter-expression "MQRankSum > 5.0" \
   --filter-name "MQRankSum_L" \
   --filter-expression "MQRankSum < -5.0" \
   --filter-name "MQRankSum_S" \
   --filter-expression "ReadPosRankSum < -4.0" \
   --filter-name "ReadPosRankSum_F" \
   --filter-expression "SOR > 3.0" \
   --filter-name "SOR_F" \
   --filter-expression "DP > 1080.0" \
   --filter-name "DP_F"

gatk --java-options "-Xmx96G" SelectVariants \
     -R Prunus_persica_v2.0.a1_scaffolds.fasta \
     -V 03_markfilter_snp.vcf \
     -O 04_rmfilter_snp.vcf \
     --exclude-filtered true

vcftools --vcf 04_rmfilter_snp.vcf \
    --minGQ 30 \
    --minDP 5 \
    --recode \
    --recode-INFO-all \
    --out 05_rmLowGQDP
