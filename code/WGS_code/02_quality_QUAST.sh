#!/bin/bash -l
#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:20:00
#SBATCH -J 02_quality_quast
#SBATCH --mail-type=ALL
#SBATCH --mail-user Alva.Annett.4036@student.uu.se

#Load modules
module load bioinfo-tools
module load quast/4.5.4
module load ABINIT/8.10.3
module load CDO/1.9.5
module load GOTM/5.3-221-gac7ec88d
module load NCO/4.8.1
module load NCO/4.9.2
module load Rosetta/3.7
module load deal.II/9.1.1-gcc
module load deal.II/9.1.1-intel
module load matplotlib/3.0.3-foss-2019a-Python-3.7.2

#------- RUN QUAST --------------------------------
# -o dir for output 
# -R refrence genome (provided) 
# -t number of threads 

quast.py \
 -o 02_quality_quast_out \
 -R /domus/h1/alvaa/private/data/reference/OBMB01.fasta \
 -t 2 \
 /domus/h1/alvaa/private/WGS/01_assembly_out/WGS_assembly.contigs.fasta 


#--------------------------------------------------


