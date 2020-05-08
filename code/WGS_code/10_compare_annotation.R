library("ape")
library(stringr)

#-------- DATA ------------------------------------------

eggNog = read.csv("C:\\Users\\alva\\Desktop\\genome_analysis\\data\\WGS_data\\09_eggNog\\09_eggNog_annotation.tsv", sep = "\t", header = F)

#OBS: Remove sequence information from gff file before reading with read.gff
prokka = read.gff("C:\\Users\\alva\\Desktop\\genome_analysis\\data\\WGS_data\\08_prokka\\prokka_annotation.gff", GFF3 = T)

#---------- combine data ---------------------------------------

#get query id and gene product as seperate columns 
id = array("", nrow(prokka))
gene_product = array("", nrow(prokka))
gene_name = array("", nrow(prokka))
for(i in 1:nrow(prokka)){
  attributes = prokka[i,]$attributes
  id[i] = str_match(attributes, "ID=(.*?)(;|$)")[,2]
  gene_product[i] = str_match(attributes, "product=(.*?)(;|$)")[,2]
  gene_name[i] = str_match(attributes, "Name=(.*?)(;|$)")[,2]
}

#add to data frame 
prokka$id = id 
prokka$gene_product = gene_product
prokka$gene_name = gene_name

#change columns to string from factor 
eggNog$V6 = as.character(eggNog$V6)
eggNog$V22 = as.character(eggNog$V22)
eggNog$V9 = as.character(eggNog$V9)

#compare gene names and make new data frame 
combined = array(data =  c("id", "name_prokka", "name_eggnog", "product_prokka", "function_eggnog", "kegg_ko"))

for(i in 1:nrow(prokka)){
  index = as.numeric(grep(prokka[i,]$id, eggNog$V1))
  
  if(length(index) == 0){
    new_row = c(prokka[i,]$id, 
                prokka[i,]$gene_name,
                NA,
                prokka[i,]$gene_product, 
                NA,
                NA)
    combined = rbind(combined, new_row)
  }
    
  else{
    new_row = c(prokka[i,]$id, 
                prokka[i,]$gene_name,
                eggNog[index,]$V6,
                prokka[i,]$gene_product, 
                eggNog[index,]$V22, 
                eggNog[index,]$V9)
    combined = rbind(combined, new_row)
  }
}

#Set colnames, rownames and remove first row 
colnames(combined) = combined[1,]
combined = combined[-1,]
rownames(combined) = seq(1:nrow(combined))

#export data 
write.csv(combined,"C:\\Users\\alva\\Desktop\\genome_analysis\\data\\WGS_data\\10_compare_annotation\\combined_annotation.csv" )

combined = read.csv("C:\\Users\\alva\\Desktop\\genome_analysis\\data\\WGS_data\\10_compare_annotation\\combined_annotation.csv", 
                    na.strings=c(""," ","NA"))

#--------- summary results ----------------------------------

#Number of hypothetical proteins from prokka 
nrow(combined[combined$product_prokka == "hypothetical protein",])
nrow(combined[is.na(combined$function_eggnog),])

nrow(combined[!is.na(combined$name_eggnog),])
nrow(combined[!is.na(combined$name_prokka),])
