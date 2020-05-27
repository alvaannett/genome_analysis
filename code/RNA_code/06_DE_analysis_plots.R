
# OBS: run 06_DE_desq2.R before or load data from that script....

#----- library ------------------------------

library(DESeq2)
library(pheatmap)
library(ggplot2)
library(stringr)

#------ LOG FOLD CHANGE ----------------------

png("C:\\Users\\alva\\Desktop\\genome_analysis\\data\\RNA_data\\06_DE_deseq2\\logfoldchange.png")

plotMA(resOrdered, ylim=c(-5,5))

dev.off()

#--------- HEATMAP -------------------------

#Prepare data for heatmap of features with p-val < 0.05
ntd <- normTransform(ddsHTSeq)
annotation <- as.data.frame(colData(ddsHTSeq)[,c("condition.treatment")])
rownames(annotation) = colData(ddsHTSeq)[,c("condition.sample")]
colnames(annotation) = c("treatment")

#Dataset with the 606 DE features
norm_matrix = assay(ntd)[resOrdered@rownames[1:n], 
                         c("ERR2036629", "ERR2036630", "ERR2036633", "ERR2036631", "ERR2036632")]

my_colour = list(treatment = c(continuous = "#d95f0e", bioleaching = "#31a354"))

#Plot heatmap
png("C:\\Users\\alva\\Desktop\\genome_analysis\\data\\RNA_data\\06_DE_deseq2\\heatmap.png")
pheatmap(norm_matrix, 
         cluster_rows=T, 
         treeheight_row = 0,
         show_rownames=F,
         cluster_cols=F,
         annotation_col = annotation, 
         annotation_colors = my_colour)

dev.off()

#-------- FUNC CATEGORYS ------------------------

#Data from article git (https://git-r3lab.uni.lu/malte.herold/LF_omics_analysis)
categ = read.csv("C:\\Users\\alva\\Desktop\\genome_analysis\\data\\meta_data\\Annotation_Tables_LF_genes_functional_categories.csv")
cog_class = read.csv("C:\\Users\\alva\\Desktop\\genome_analysis\\data\\meta_data\\Annotation_Tables_fun2003-2014.csv")

#remove ko: from each kegg id 
sign_lfc_matrix$kegg_ko = as.character(sign_lfc_matrix$kegg_ko)
sign_lfc_matrix$Row.names = as.character(sign_lfc_matrix$Row.names)

new_kegg = array("")
gene_id = array("")
for(i in 1:nrow(sign_lfc_matrix)){
  ko = strsplit(sign_lfc_matrix$kegg_ko[i], ",")[[1]]
  for(j in 1:length(ko)){
    new_kegg = append(new_kegg, ko[j])
    gene_id = append(gene_id, sign_lfc_matrix$Row.names[i])
  } 
}

for(i in 1:length(new_kegg)){
  new_kegg[i] = strsplit(new_kegg[i], "[:]")[[1]][2]
}

new_kegg = cbind.data.frame(gene_id, new_kegg)

df = merge(new_kegg, sign_lfc_matrix, by.x = "gene_id", by.y = "Row.names")

#link the kegg id's to cog categories 
df = merge(df, categ[, c("KO", "COG_category")], 
           by.x = "new_kegg", by.y = "KO",
           all.x = T)

#remove duplicate rows
df = df[!duplicated(df),]

df$COG_category = as.character(df$COG_category)
df$gene_id = as.character(df$gene_id)
df[df==""]<-NA  #change empty values to NA 
new_cog = array(data = c("cog", "row"))
for(i in 1:nrow(df)){
  if(!is.na(df[i, 10])){
    cog = unlist(strsplit(df[i, "COG_category"], ""))
    for(j in 1:length(cog)){
      new_line = c(cog[j], df[i,"gene_id"])
      new_cog = rbind(new_cog, new_line)
    }
  }
  else{
    new_line = c(df[i, "COG_category"], df[i,"gene_id"])
    new_cog = rbind(new_cog, new_line)
  }
}
colnames(new_cog) = new_cog[1,]
new_cog = new_cog[-1,]

df = merge(df, new_cog, by.x = "gene_id", by.y = "row")

#add cog class names 
colnames(cog_class) = c("cog", "name")
df = merge(df, cog_class, by.x = "cog", by.y = "cog", all.x = T) 

#add up/down for plotting 
df$regulation <- ifelse(df$log2FoldChange >=0, "up", "down")


png("C:\\Users\\alva\\Desktop\\genome_analysis\\data\\RNA_data\\06_DE_deseq2\\LCF_cog.png",
    width = 1500, height = 800, units = "px")
ggplot(df, aes(x = log2FoldChange, y = name, color = regulation)) +
  geom_point(size = 3) +
  scale_color_manual(values = alpha(c("#2c7fb8", "#f03b20"), 0.6)) +
  xlab("LFC") +
  ylab("") +
  theme_bw() +
  theme(text = element_text(size = 30)) 
dev.off()

ggplot(df, aes(x = name, fill = regulation)) +
  geom_bar(stat = "count", position = position_dodge(width = 0.8)) +
  scale_fill_manual(values = alpha(c("#2c7fb8", "#f03b20"), 0.6)) +
  theme_bw()


x = vst(ddsHTSeq)

png("C:\\Users\\alva\\Desktop\\genome_analysis\\data\\RNA_data\\06_DE_deseq2\\pca.png",
    width = 800, height = 500, units = "px")
plotPCA(x, intgroup=c("condition.treatment")) +
  geom_point(size = 5) +
  scale_color_manual(values = c("#d95f0e", "#31a354")) +
  theme_bw() +
  theme(text = element_text(size = 30)) 
dev.off()
