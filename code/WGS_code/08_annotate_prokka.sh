#!/bin/bash -l
#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:30:00
#SBATCH -J 08_prokka  
#SBATCH --mail-type=ALL
#SBATCH --mail-user Alva.Annett.4036@student.uu.se

#load modules 
module load bioinfo-tools
module load prokka/1.12-12547ca

#--------- RUN PROKKA --------------------------------

# input fasta file 
# out dir 
# prefix for files 

prokka \
 /domus/h1/alvaa/private/WGS/01_assembly_out/tig00004064.fasta \
 --outdir 08_prokka_annotation_out \
 --prefix prokka_annotation 
 #-----------------------------------------------------