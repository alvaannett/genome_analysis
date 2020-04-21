#!/bin/bash -l
#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 24:00:00
#SBATCH -J 06_circlator 
#SBATCH --mail-type=ALL
#SBATCH --mail-user Alva.Annett.4036@student.uu.se

#Load modules
module load bioinfo-tools
module load circlator/1.5.5
module load bwa/0.7.17
module load prodigal/2.6.3
module load samtools/1.10
module load MUMmer/4.0.0beta2
module load canu/1.8
module load python/3.7.2

# extract long contig from .contigs.fasta file from canu output and use this as input file

#----------- RUN CIRCLATOR ----------------------------------------------
# all : run all steps in one pipline 
# -- assembler use canu to reassembly contig ends
# --threads 
# --verbose prints progress information 
# assembly in fasta format 
# corrected reads 
# output dir 

circlator all \
 --assembler canu \
 --threads 2 \
 --verbose \
 /domus/h1/alvaa/private/WGS/01_assembly_out/tig00004064.fasta \
 /domus/h1/alvaa/private/WGS/01_assembly_out/WGS_assembly.trimmedReads.fasta.gz \
 06_circlator_out  

#-----------------------------------------------------------------------