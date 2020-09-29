#!/bin/bash

bwa index -p peach Prunus_persica_v2.0.a1_scaffolds.fasta

samtools faidx Prunus_persica_v2.0.a1_scaffolds.fasta

/sfs/fs6/home-geomar/smomw353/tools/gatk-4.1.1.0/gatk --java-options "-Xmx96G" CreateSequenceDictionary \
-R Prunus_persica_v2.0.a1_scaffolds.fasta
