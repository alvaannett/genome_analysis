
#Data: combined annotation from 10_compare_annotation.R 
combined = read.csv("C:\\Users\\alva\\Desktop\\genome_analysis\\data\\WGS_data\\10_compare_annotation\\combined_annotation.csv", 
                    na.strings=c(""," ","NA"))

sign_lfc_matrix = read.csv("C:\\Users\\alva\\Desktop\\genome_analysis\\data\\RNA_data\\06_DE_deseq2\\sign_genes.csv")


#remove ko: from kegg id 
combined$kegg_ko = as.character(combined$kegg_ko)
combined$id = as.character(combined$id)

new_kegg = array("")
gene_id = array("")
for(i in 1:nrow(combined)){
  ko = strsplit(combined$kegg_ko[i], ",")[[1]]
  for(j in 1:length(ko)){
    new_kegg = append(new_kegg, ko[j])
    gene_id = append(gene_id, combined$id[i])
  } 
}

for(i in 1:length(new_kegg)){
  new_kegg[i] = strsplit(new_kegg[i], "[:]")[[1]][2]
}

new_kegg = cbind.data.frame(gene_id, new_kegg)

new_kegg = merge(new_kegg, sign_lfc_matrix[, c("Row.names", "log2FoldChange")], by.x = "gene_id", by.y = "Row.names")

#add up/down
new_kegg$regulation <- ifelse(new_kegg$log2FoldChange >=0, "up", "down")

write.csv(new_kegg, file = "C:\\Users\\alva\\Desktop\\genome_analysis\\data\\RNA_data\\kegg_id.csv")
