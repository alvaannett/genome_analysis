#!/bin/bash -l
#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:00:00
#SBATCH -J 09_eggnog  
#SBATCH --mail-type=ALL
#SBATCH --mail-user Alva.Annett.4036@student.uu.se

#load modules 
module load bioinfo-tools
module load eggNOG-mapper/1.0.3

#----------- RUN EGGNOG ----------------------------------

# input file 
# output dir
# algorithm 

python emapper.py \
 -i #input file \
 --output eggnog_annotate_out \
 -m HMM

#---------------------------------------------------------