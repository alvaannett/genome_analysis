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

#-------- run canu ---------------------------- 
# -p prefix filenames 
# -d dir to run in
# -pacbio-raw specifies the data type 
# genomeSize needs to be specified 
# stopOnReadQuality mentioned in the student manual 
canu \
 -p L.Ferr -d 01_assembly \
 -pacbio-raw data/DNA_raw_data/ERR2028?.fastq.gz \
 genomeSize= \
 stopOnReadQuality=false 
