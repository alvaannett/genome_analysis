
#Make db of genome 
makeblastdb -in L.ferrooxidans.genome.fasta -dbtype nucl

#run blastn 
blastn -query tig00004064.fasta -db L.ferrooxidans.genome.fasta -evalue 1 -task blastn -outfmt 6 > ACT_comp_file.crunch
