#!/bin/bash

#load modules 
module load bioinfo-tools
module load FastQC/0.11.8

#-------- RUN FASTQC (raw reads) --------------------------------

fastqc \
 -o 01_quality_raw_reads \
 -t 2 \
 /domus/h1/alvaa/private/data/RNA_raw_data/ERR2036629_1.fastq.gz \
 /domus/h1/alvaa/private/data/RNA_raw_data/ERR2036629_2.fastq.gz \
 /domus/h1/alvaa/private/data/RNA_raw_data/ERR2117290_1.fastq.gz \
 /domus/h1/alvaa/private/data/RNA_raw_data/ERR2117290_2.fastq.gz

#-----------------------------------------------------
