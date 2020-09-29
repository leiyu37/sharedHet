#!/bin/bash

bwa mem -R "@RG\tID:PEACH01\tSM:PEACH01\tPL:illumina\tLB:PXL_B1-1L1\tPU:unit" -M peach SRR8204278_1.fastq SRR8204278_2.fastq>PEACH01.sam
samtools view -Sb PEACH01.sam >PEACH01.bam
samtools sort PEACH01.bam >PEACH01_sort.bam
gatk --java-options "-Xmx30G" MarkDuplicates -I PEACH01_sort.bam -O PEACH01_markdup.bam -M PEACH01_metrics.txt -MAX_FILE_HANDLES 1000
samtools index PEACH01_markdup.bam
