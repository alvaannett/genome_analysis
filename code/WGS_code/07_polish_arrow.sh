#!/bin/bash -l
#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 24:00:00
#SBATCH -J 07_arrow  
#SBATCH --mail-type=ALL
#SBATCH --mail-user Alva.Annett.4036@student.uu.se

#load modules 
module load bioinfo-tools
module load bwa/0.7.17
module load samtools/1.10
module load SMRT/7.0.1

#----- RUN BWA (align reads to assembly) ----------

# 1. index refrence file 
bwa index \
 -p WGS_assembly_index \
 /domus/h1/alvaa/private/WGS/01_assembly_out/WGS_assembly.contigs.fasta


# 2. align reads and output .bam file 
# -t threads 
# indexed refrence file from above 
# raw reads 
# sort output and trnasform to .bma file 
bwa mem \
 -t 2 \
 WGS_assembly_index \
 <(cat /domus/h1/alvaa/private/data/DNA_raw_data/ERR*.fastq.gz) \
 | samtools sort -o aligned_reads.bam -
#--------------------------------------------------

#--------- RUN ARROW ------------------------------

# aligned reads from above 
# indexed refrence genome from above 
# output ploished genome .gff, .fasta and .fastq 
arrow \
/domus/h1/alvaa/private/WGS/aligned_reads.bam \
-r /domus/h1/alvaa/private/WGS/01_assembly_out/WGS_assembly.contigs.fasta.fai \
-o arrow_variants.gff \
-o arrow_consensus.fasta \
-o arrow_consensus.fastq

#--------------------------------------------------