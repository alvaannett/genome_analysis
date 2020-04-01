#!/bin/bash -l
#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:10:00
#SBATCH -J 03_align_nucmer
#SBATCH --mail-type=ALL
#SBATCH --mail-user Alva.Annett.4036@student.uu.se

#Load modules
module load bioinfo-tools
module load MUMmer/4.0.0beta2
module load samtools/1.10

#--------- RUN NUCMER -------------------------------------

# -p prefic for output files 
# --delta dir for output 
# threads 
# refrence
# contigs 

nucmer \
 --prefix=03_align_quality_nucmer_out \
 --threads=2 \
 /domus/h1/alvaa/private/data/reference/OBMB01.fasta \
 /domus/h1/alvaa/private/WGS/01_assembly_out/WGS_assembly.contigs.fasta 

#Takes output from nucmer and creates file with summary statistics etc...
# -r sort output lines by reference
# -c sequence length columns in the output
# -l percent coverage columns in the output
# -T tab delimited output 
show-coords -r - c  -l -T \
 03_align_quality_nucmer_out.delta > 03_align_quality_nucmer_out.coords.txt 

#create index fasta file from refrence genome for plotting 
samtools faidx /domus/h1/alvaa/private/data/reference/OBMB01.fasta > OBMB01.fasta.fai

#----------------------------------------------------------
