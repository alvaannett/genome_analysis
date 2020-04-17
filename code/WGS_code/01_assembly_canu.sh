#!/bin/bash -l
#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 15:00:00
#SBATCH -J 01_assembly_L.ferr_WGS
#SBATCH --mail-type=ALL
#SBATCH --mail-user Alva.Annett.4036@student.uu.se

#Load modules
module load bioinfo-tools
module load canu/1.8
module load emboss/6.6.0

#-------- RUN CANU ---------------------------------

# -p prefix filenames
# -d dir to run in
# -pacbio-raw specifies the data type (we have raw PacBio reads...)
# genomeSize needs to be specified (taken from article)
# stopOnReadQuality as mentioned in the student manual

canu \
 -p WGS_assembly \
 -d 01_assembly_out \
 genomeSize=2.6m \
 stopOnReadQuality=false \
 -pacbio-raw /domus/h1/alvaa/private/data/DNA_raw_data/ERR*.fastq.gz

#infoseq to tsv file 
infoseq WGS_assembly.contigs.fasta > info_contigs.tsv
#--------------------------------------------------