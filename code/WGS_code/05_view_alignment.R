
#------- INSTALL -----------------------------

install.packages(c("devtools", "ggplot2"))

library(devtools)
install_github("timflutre/rutilstimflutre", force = TRUE)

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install(c("ggbio", "GenomicRanges"))

#----------- LIB -------------------------------------
library(rutilstimflutre)
library(GenomicRanges)
library(ggplot2)
library(ggbio)
library(GenomicRanges)
#----------- FUNCTIONS -------------------------------                    

load_coords <- function(coords_file, perc.id) {
  coords <- loadMummer(coords_file, algo = "nucmer")                    # read in nucmer results as a GRanges obj
  coords <- coords[(elementMetadata(coords)[ , "perc.id"] >= perc.id)]  # filter entries with perc.id != 100
  seqlevels(coords) <- seqlevelsInUse(coords)                           # drop seq levels that are no longer used
  coords$qry.name <- names(coords)                                      # set column with query contig name
  coords$qry <- rep("Query", nrow(values(coords)))
  
  return(coords)
}

faidx_to_GRanges <- function(faidx_file){
  faidx <- read.table(file = faidx_file, header = F, stringsAsFactors = F,
                      col.names = c("name", "contig.len", "offset", 
                                    "linebases", "linewidth"))
  
  # create a GRanges object for reference sequences
  grange <- GRanges(seqnames = Rle(faidx$name), 
                    ranges = IRanges(start = rep(1, nrow(faidx)), 
                                     end = faidx$contig.len))
  
  # add seqlengths to the reference GRanges object
  seqlengths(grange) <- faidx$contig.len
  genome(grange) <- "Reference"
  grange <- sortSeqlevels(grange)
  grange <- sort(grange)
  return(grange)
}

circular_plot_w_ref <- function(reference_GRange, NUCmer_coords){
  # reference_GRange: reference sequence GRanges obj
  # NUCmer_coords: a GRanges object produced by reading in a show-coords processed NUCmer object.
  
  p <- ggbio() + 
    circle(NUCmer_coords, geom = "rect", 
           aes(color = "steelblue", fill = "steelblue")) +  # NUCmer obj
    circle(reference_GRange, geom = "ideo", 
           aes(color = "gray70", fill = "gray70")) +        # Ideogram of ref genome
    circle(reference_GRange, geom = "scale", 
           scale.type = "M", size = 1.5) +                  # Scale from seqlen of ref genome
     circle(reference_GRange, geom = "text", 
           aes(label = seqnames), size = 2) +              # Uncomment for sequence label
    scale_color_manual(name = "Sequence Origin", 
                       labels = c("Reference", "Query"), 
                       values = c("gray70", "steelblue")) +
    scale_fill_manual(name = "Sequence Origin", 
                      labels = c("Reference", "Query"), 
                      values = c("gray70", "steelblue")) +
    ggtitle("Reference vs. Query")
  return(p)
}

#----------------------------------------------------------------------------------------------

#File paths to nucmer output from show-cords and .fai file of refrnece genome. 
NUCmer_coords_file = "C:\\Users\\alva\\Desktop\\genome_analysis\\data\\WGS_data\\03_nucmer\\03_align_quality_nucmer_out.coords.txt" 
ref_faidx_file = "C:\\Users\\alva\\Desktop\\genome_analysis\\data\\WGS_data\\03_nucmer\\OBMB01.fasta.fai"
perc.id = 80

#read data 
NUCmer_coords <- load_coords(NUCmer_coords_file, perc.id = perc.id)   # Make GRanges obj of nucmer output file
referenceGR <- faidx_to_GRanges(faidx_file = ref_faidx_file)

#plot 
png("C:\\Users\\alva\\Desktop\\genome_analysis\\data\\WGS_data\\03_nucmer\\alignemnt.png")

circular_plot_w_ref(reference_GRange = referenceGR, NUCmer_coords = NUCmer_coords)

dev.off()
