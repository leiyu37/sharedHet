#!/bin/bash

gatk --java-options "-Xmx96G" CombineGVCFs \
-R Prunus_persica_v2.0.a1_scaffolds.fasta \
--variant PEACH01.g.vcf \
--variant PEACH02.g.vcf \
--variant PEACH03.g.vcf \
--variant PEACH04.g.vcf \
--variant PEACH05.g.vcf \
--variant PEACH06.g.vcf \
--variant PEACH07.g.vcf \
--variant PEACH08.g.vcf \
--variant PEACH09.g.vcf \
--variant PEACH10.g.vcf \
--variant PEACH11.g.vcf \
--variant PEACH12.g.vcf \
--variant PEACH13.g.vcf \
-O peach_merge.g.vcf

gatk --java-options "-Xmx96G" GenotypeGVCFs \
-R Prunus_persica_v2.0.a1_scaffolds.fasta \
-V peach_merge.g.vcf \
-O peach_raw.vcf
