
#------ install ------------------------------------
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DESeq2")

install.packages("pheatmap")

#------ library -----------------------------------

library(DESeq2)

#------ data --------------------------------------

#annotation data from "10_compare_annotation.R"
combined = read.csv("C:\\Users\\alva\\Desktop\\genome_analysis\\data\\WGS_data\\10_compare_annotation\\combined_annotation.csv", na.strings=c(""," ","NA"))

#Dir with htseq count data 
htseq_dir = "C:\\Users\\alva\\Desktop\\genome_analysis\\data\\RNA_data\\05_count_reads_reverse_htseq"

#file names 
sampleFiles <- grep("ERR",list.files(htseq_dir),value=TRUE)

#conditions 
sampleCondition <- read.table("C:\\Users\\alva\\Desktop\\genome_analysis\\data\\meta_data\\treatment.csv",
                              sep = ",", 
                              header = T)

#create table 
sampleTable <- data.frame(sampleName = sampleCondition$sample,
                          fileName = sampleFiles,
                          condition = sampleCondition)


#create htseq object 
ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                       directory = htseq_dir,
                                       design= ~ condition.treatment)
#check data 
ddsHTSeq

#filter low counts 
keep <- rowSums(counts(ddsHTSeq)) >= 10
ddsHTSeq <- ddsHTSeq[keep,]

#set refrence level to continous  
ddsHTSeq$condition.treatment <- relevel(ddsHTSeq$condition.treatment, ref = "continuous")

#------ DE analysis ---------------------------------------------

ddsHTSeq <- DESeq(ddsHTSeq)
resultsHTseq <- results(ddsHTSeq, alpha = 0.05)

#order results by p-value 
resOrdered <- resultsHTseq[order(resultsHTseq$pvalue),]

#summary 
summary(resOrdered)

#number of significant = 606 
n = sum(resOrdered$padj < 0.05, na.rm=TRUE)

#save lcf for later...
lfc_matrix = as.data.frame(resOrdered[, c("log2FoldChange", "padj")])
rownames(lfc_matrix) = resOrdered@rownames

#data frame with sig features --> bind with annotation data
sign_lfc_matrix = lfc_matrix[lfc_matrix$padj < 0.05 & !is.na(lfc_matrix$padj),]
sign_lfc_matrix = merge(sign_lfc_matrix, combined, by.x = "row.names", by.y = "id")
sign_lfc_matrix = sign_lfc_matrix[, !colnames(sign_lfc_matrix) %in% c("X")]

write.csv(sign_lfc_matrix, "C:\\Users\\alva\\Desktop\\genome_analysis\\data\\RNA_data\\06_DE_deseq2\\sign_genes.csv")
