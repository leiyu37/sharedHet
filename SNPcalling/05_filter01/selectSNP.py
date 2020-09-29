#!/usr/bin/env python3
vcf = "01_indelDistance_snp.vcf"

f_in = open(vcf)
f_out = open("02_select_snp.vcf", "w")

for line in f_in.readlines():
    if line.startswith("#"):
        f_out.write(line)
    else:
        columns = line.split()
        chrom = columns[0]
        ref = columns[3]
        var = columns[4]

        if (chrom.startswith("Pp0")) and (len(ref) == 1) and (len(var) == 1):
            f_out.write(line)
f_in.close()
f_out.close()
