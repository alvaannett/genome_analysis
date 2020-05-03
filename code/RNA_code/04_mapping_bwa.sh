#!/bin/bash -l
#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 15:00:00
#SBATCH -J 04_mapping
#SBATCH --mail-type=ALL
#SBATCH --mail-user Alva.Annett.4036@student.uu.se

#Load modules
module load bioinfo-tools
module load bwa/0.7.17
module load samtools/1.10

#------ RUN BWA --------------------------------

# index refrence genome 
bwa index \
 -p WGS_assembly_index \
 /domus/h1/alvaa/private/WGS/01_assembly_out/tig00004064.fasta

# run bwa-mem (long reads from 70 bp) on 1P and 2P files from 
# trimmed reads 

path="/crex/proj/g2020008/3_Christel_2017/RNA_trimmed_reads/"
P1="_P1.trim.fastq.gz"
P2="_P2.trim.fastq.gz"

#todo: läs filnamn automatikst... itterera över två listor samtidigt? 
for f in ERR2036629 ERR2036630 ERR2036631 ERR2036632 ERR2036633 \
ERR2117288 ERR2117289 ERR2117290 ERR2117291 ERR2117292
do
 echo "start" $f

 #define file paths 
 file_P1=$path$f$P1
 file_P2=$path$f$P2
 
 #run bwa, sort output and save as .bam
 bwa mem \
 -t 2 \
 WGS_assembly_index \
 $file_P1 \
 $file_P2 \
 | samtools sort -o $f.bam 
 
 echo "done" $f
done