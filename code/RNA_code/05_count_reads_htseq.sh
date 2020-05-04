#!/bin/bash -l
#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 10:00:00
#SBATCH -J 05_count_reads
#SBATCH --mail-type=ALL
#SBATCH --mail-user Alva.Annett.4036@student.uu.se

#Load modules
module load bioinfo-tools
module load htseq/0.9.1 

#--------- RUN HTSEQ -----------------------------

path="/domus/h1/alvaa/private/RNA/04_mapp_bwa_out/"
pref=".bam"

#todo: läs filnamn automatikst...  
for f in ERR2036629 ERR2036630 ERR2036631 ERR2036632 ERR2036633
do
 echo "start" $f

 #define file path 
 file=$path$f$pref
 
# -f input file in bam format 
# -r bam file is sorted by order 
# -o sam record file 
# -t type of feature 
# -i ID instead of gene_id in GFF file 
# alignemnt files from bwa 
# gff_file from anotated genome 
 htseq-count \
    -f bam \
    -r pos \
    -t CDS \
    -i ID \
    $file \
    /domus/h1/alvaa/private/WGS/08_prokka_annotation_out/prokka_annotation.gff \
    > $f.txt

 echo "done" $f
done

#-------------------------------------------------
