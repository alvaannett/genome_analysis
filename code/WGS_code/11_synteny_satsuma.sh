#!/bin/bash -l
#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 15:00:00
#SBATCH -J 11_synteny
#SBATCH --mail-type=ALL
#SBATCH --mail-user Alva.Annett.4036@student.uu.se

#Load modules
module load bioinfo-tools
module load satsuma2/2016-12-07

#------ RUN SATSUMA ----------------------------------

SatsumaSynteny2 \
 -q /domus/h1/alvaa/private/WGS/01_assembly_out/tig00004064.fasta \
 -t /domus/h1/alvaa/private/WGS/11_synteny_out/L.ferrooxidans.genome.fasta \
 -o /domus/h1/alvaa/private/WGS/11_synteny_out \
 -threads 2 

#-----------------------------------------------------