#!/bin/bash -l
#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J 02_trimmomatic
#SBATCH --mail-type=ALL
#SBATCH --mail-user Alva.Annett.4036@student.uu.se

#Load modules
module load bioinfo-tools
module load trimmomatic/0.36

#!/bin/bash -l
#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J 02_trimmomatic
#SBATCH --mail-type=ALL
#SBATCH --mail-user Alva.Annett.4036@student.uu.se

#Load modules
module load bioinfo-tools
module load trimmomatic/0.36

#---------- RUN TRIMMOMATIC ----------------------------------

# -treads 
# -trimlog name for log file 
# forward file 
# reverse file 
# -baseout derive output file names 
# ILLUMINACLIP : fasta file with adapters : seed mismatches : palindrome clip threshold : simple clip threshold 
# LEADING : minimum quality to keep base at begining 
# TRAILING : minimum quality to keep base at end 
# SLIDINGWINDOW : windiw size : minimum quality 
# MINLEN : reads shorter than this will be discarded 

#Run for continous sample 
java -jar $TRIMMOMATIC_HOME/trimmomatic.jar PE \
 -threads 2 \
 -trimlog ERR2036629_log \
 /domus/h1/alvaa/private/data/RNA_raw_data/ERR2036629_1.fastq.gz \
 /domus/h1/alvaa/private/data/RNA_raw_data/ERR2036629_2.fastq.gz \
 -baseout ERR2036629_trimmed.fastq.gz \
 ILLUMINACLIP:/domus/h1/alvaa/private/RNA/02_trimmomatic/TruSeq3-PE.fa:2:30:10 \
 LEADING:10 \
 TRAILING:10 \
 SLIDINGWINDOW:5:20 \
 MINLEN:50  

#Run for bioleaching sample 
java -jar $TRIMMOMATIC_HOME/trimmomatic.jar PE \
 -threads 2 \
 -trimlog ERR2117290_log \
 /domus/h1/alvaa/private/data/RNA_raw_data/ERR2117290_1.fastq.gz \
 /domus/h1/alvaa/private/data/RNA_raw_data/ERR2117290_2.fastq.gz \
 -baseout ERR2117290_trimmed.fastq.gz \
 ILLUMINACLIP:/domus/h1/alvaa/private/RNA/02_trimmomatic/TruSeq3-PE.fa:2:30:10 \
 LEADING:10 \
 TRAILING:10 \
 SLIDINGWINDOW:5:20 \
 MINLEN:50  

#-------------------------------------------------------------



