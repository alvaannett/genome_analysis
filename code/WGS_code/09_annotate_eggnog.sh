#!/bin/bash -l
#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J 09_eggnog  
#SBATCH --mail-type=ALL
#SBATCH --mail-user Alva.Annett.4036@student.uu.se

#load modules 
module load bioinfo-tools
module load eggNOG-mapper/1.0.3

#----------- RUN EGGNOG ----------------------------------
# Use the predicted genes from prodigal (prokka).
# .ffn file from prokka output contains nucleotide seq of
# all genomic features 

# input file 
# -i output file names 
# -m algorithm 
# -d databse 
# --output_dir 
# --output generate filenames 
# --data_dir database 
/sw/bioinfo/eggNOG-mapper/1.0.3/rackham/emapper.py \
 -i /domus/h1/alvaa/private/WGS/08_prokka_annotation_out/prokka_annotation.ffn \
 -m hmmer \
 -d bact \
 --output_dir 09_eggnog_annotate_out \
 --output 09_eggnog \
 --data_dir /crex/data/eggNOG/4.5.1/ 

#---------------------------------------------------------