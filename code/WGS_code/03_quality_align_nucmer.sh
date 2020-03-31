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

#--------- RUN NUCMER -------------------------------------
# -p prefic for output files 
# --delta dir for output 
# threads 
# refrence
# contigs 

nucmer \
 -p=align_nucmer \
 --delta=03_align_quality_mummer \
 --threads=2 \
 /domus/h1/alvaa/private/data/reference/OBMB01.fasta \
 /domus/h1/alvaa/private/WGS/01_assembly_out/WGS_assembly.contigs.fasta 

#----------------------------------------------------------