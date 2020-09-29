#!/usr/bin/env python3
import random
n_loci = 70000
n_descendants = 13

genotypes = ["0/1", "0/1", "0/0", "1/1"]


f_out = open("simulatedSelfing.vcf", "w")
f_out.write("##fileformat=VCFv4.2\n")
f_out.write("#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tP")

for i in range(1, n_descendants + 1):
    f_out.write("\tD{}".format(i))
f_out.write("\n")

for i in range(1, n_loci + 1):
    f_out.write("CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t0/1")
    for j in range(1, n_descendants + 1):
        genotype = random.choice(genotypes)
        f_out.write("\t{}".format(genotype))
    f_out.write("\n")

f_out.close()
