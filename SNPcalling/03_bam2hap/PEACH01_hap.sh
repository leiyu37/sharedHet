#!/bin/bash

gatk --java-options "-Xmx40G" HaplotypeCaller -R Prunus_persica_v2.0.a1_scaffolds.fasta -I PEACH01_markdup.bam -O PEACH01.g.vcf -ERC GVCF
