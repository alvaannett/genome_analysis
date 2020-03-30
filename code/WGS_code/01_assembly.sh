#!/bin/bash -l   
#SBATCH -A g2020008 
#SBATCH -p core 
#SBATCH -n 2 
#SBATCH -t 00:00:00 
#SBATCH -J 01_assembly  
#SBATCH --mail-type=ALL 
#SBATCH --mail-user alva.anett@gmail.com 

#Load modules 
module load bioinfo-tools 
module load canu

#-------- run canu ---------------------------- 

# -p prefix filenames 
# -d dir to run in
# -pacbio-raw specifies the data type 
# genomeSize needs to be specified (taken from article) 
# stopOnReadQuality mentioned in the student manual

canu \
 -p WGSi_assembly \
 -d 01_assembly \
 genomeSize=2.6m \
 stopOnReadQuality=false \
 -pacbio-raw data/DNA_raw_data/ERR2028?.fastq.gz 

#----------------------------------------------
