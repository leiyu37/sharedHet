#!/usr/bin/env python3
#Version 1.0
#Lei Yu Sep 24th, 2020
#Email: leiyu2010ouc@outlook.com
import argparse
import subprocess

# Define functions.
def calculateAB(vcf_path, m, n):
    """
    Calculate na, nab, and fab.
    na: number of loci where sample_01 is heterozygous, and sample_02 is not "./.".
    nab: number of loci where both sample_01 and sample_02 are heterozygous.
    fab: nab/na
    """
    na = 0
    nab = 0
    f_in = open(vcf_path)
    for line in f_in.readlines():
        if not line.startswith("#"):
            columns = line.split()
            geno_01 = columns[m][0] + columns[m][2]
            geno_02 = columns[n][0] + columns[n][2]
            if (geno_01 == "01" or geno_01 == "10") and (geno_02 in ["00", "01", "10", "11"]):
                na += 1
                if geno_02 == "01" or geno_02 == "10":
                    nab += 1
    f_in.close()
    fab = round(nab/na, 4)
    return(na, nab, fab)

def calculateBA(vcf_path, m, n):
    """
    Calculate nb, nba, and fba.
    nb: number of loci where sample_02 is heterozygous, and sample_01 is not "./.".
    nba: number of loci where both sample_01 and sample_02 are heterozygous.
    fba: nba/nb
    """
    nb = 0
    nba = 0
    f_in = open(vcf_path)
    for line in f_in.readlines():
        if not line.startswith("#"):
            columns = line.split()
            geno_01 = columns[m][0] + columns[m][2]
            geno_02 = columns[n][0] + columns[n][2]
            if (geno_02 == "01" or geno_02 == "10") and (geno_01 in ["00", "01", "10", "11"]):
                nb += 1
                if geno_01 == "01" or geno_01 == "10":
                    nba += 1
    f_in.close()
    fba = round(nba/nb, 4)
    return(nb, nba, fba)

# Process input parameters.
parser = argparse.ArgumentParser(description="Detect asexual reproduction and selfing in diploid species based on shared heterozygosity.")
parser.add_argument("vcf_path", help = "The path to the vcf file.")
parser.add_argument("sample_pop_list", help = "The path to a file containing sample name and its corresponding population name.")
args = parser.parse_args()
vcf_path = args.vcf_path
sample_pop_list = args.sample_pop_list

# keep only two-allele SNPs in a file named "temp.vcf".
f_in = open(vcf_path)
f_out = open("temp.vcf", "w")
for line in f_in.readlines():
    if line.startswith("#"):
        f_out.write(line)
    else:
        columns = line.split()
        ref = columns[3]
        var = columns[4]
        if len(ref) == 1 and len(var) == 1:
            f_out.write(line)
f_in.close()
f_out.close()

# Generate a dictionary with 0-based index as key and sample name as value.
i_sample_dict = {}
f_in = open("temp.vcf")
for line in f_in.readlines():
    if line.startswith("#CHROM"):
        columns = line.split()
        for i in range(9, len(columns)):
            sample = columns[i]
            i_sample_dict[i] = sample
        break
f_in.close()

# Genarate a dictionary based on the input "sample_pop_list", with sample name as key and population name as value.
sample_pop_dict = {}
f_in = open(sample_pop_list)
for line in f_in.readlines():
    columns = line.split()
    sample = columns[0]
    pop = columns[1]
    sample_pop_dict[sample] = pop
f_in.close()

# Calculation. Results are stored in "01_sharedHet.txt"
f_out = open("01_sharedHet.txt", "w")
f_out.write("Sample_01\tSample_02\tNa\tNab\tFab\tNb\tNba\tFba\n")

n = len(i_sample_dict.keys())
n_col = n + 9

for m in range(9, n_col-1):
    for n in range(m+1, n_col):
        sample_01 = i_sample_dict[m]
        sample_02 = i_sample_dict[n]
        if (sample_01 in sample_pop_dict.keys()) and (sample_02 in sample_pop_dict.keys()):
            if sample_pop_dict[sample_01] == sample_pop_dict[sample_02]:
                f_out.write("{}\t{}".format(sample_01, sample_02))
                na,nab,fab = calculateAB("temp.vcf",m,n)
                nb,nba,fba = calculateBA("temp.vcf",m,n)
                f_out.write("\t{}\t{}\t{}\t{}\t{}\t{}\n".format(na,nab,fab,nb,nba,fba))
f_out.close()

cmd = "rm temp.vcf"
subprocess.call(cmd, shell="True")
