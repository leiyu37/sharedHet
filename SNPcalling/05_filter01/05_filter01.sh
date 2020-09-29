#!/bin/bash


bcftools filter --SnpGap 20 -o 01_indelDistance_snp.vcf -O v peach_raw.vcf

chmod 700 selectSNP.py
./selectSNP.py
