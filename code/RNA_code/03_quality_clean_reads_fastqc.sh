#!/bin/bash -l
#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:30:00
#SBATCH -J 03_quality_clean_reads 
#SBATCH --mail-type=ALL
#SBATCH --mail-user Alva.Annett.4036@student.uu.se

#load modules 
module load bioinfo-tools
module load FastQC/0.11.8

#-------- RUN FASTQC (clean reads) ------------------------------

# -o derive output names
# -t threads 
# files 

fastqc \
 -o 03_quality_clean_reads_out \
 -t 2 \
 /domus/h1/alvaa/private/RNA/02_trimmomatic/ERR2036629_trimmed_1P.fastq.gz \
 /domus/h1/alvaa/private/RNA/02_trimmomatic/ERR2036629_trimmed_2P.fastq.gz \
 /domus/h1/alvaa/private/RNA/02_trimmomatic/ERR2117290_trimmed_1P.fastq.gz \
 /domus/h1/alvaa/private/RNA/02_trimmomatic/ERR2117290_trimmed_2P.fastq.gz 

#------------------------------------------------------------------
