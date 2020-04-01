#!/bin/bash -l
#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:10:00
#SBATCH -J 04_mummmerplot
#SBATCH --mail-type=ALL
#SBATCH --mail-user Alva.Annett.4036@student.uu.se

#Load modules
module load bioinfo-tools
module load MUMmer/4.0.0beta2

#------- RUN MUMMERPLOT -----------------------------
# --png to produce png output 

mummerplot \
 --prefix=04_quality_mummerplot_out \
 --png \
 /domus/h1/alvaa/private/WGS/03_nucmer_out/03_align_quality_nucmer_out.delta

#----------------------------------------------------