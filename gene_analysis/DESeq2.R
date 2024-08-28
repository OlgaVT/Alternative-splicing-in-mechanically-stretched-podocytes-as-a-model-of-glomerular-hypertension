library(DESeq2)
library (optparse)

option_list <- list(make_option(c("-g","--genecnt"),default=NA, type='character', help="gene count file"),
make_option(c("-m","--metadata"),default=NA, type='character', help="metadata"),
make_option(c("-i","--image"),default=NA, type='character', help="where to save R image"))

opt = parse_args(OptionParser(option_list=option_list))

#read gene count file
cts <- read.csv(opt$g,sep='\t',row.names=1)
head(cts)

#read the metadata file
coldata <- read.csv(opt$m, sep = ',', row.names=1)
coldata

cts_analyze <- cts[, c(rownames(coldata))] #be carefull '-' sign is converted to '.' in deseq2
cts_analyze <- cts_analyze[rowSums(cts_analyze)!=0,] #filter non-expressed genes
all(colnames(cts_analyze) %in% rownames(coldata)) #must be TRUE!
head(cts_analyze)

dds <- DESeqDataSetFromMatrix(countData = cts_analyze, colData = coldata, design = ~ condition)

dds <- DESeq(dds)
res <- results(dds)
write.csv(as.data.frame(res), file = 'output')
resSig <- subset(res, padj < 0.05)
write.csv(as.data.frame(resSig), file = 'significant')

save.image(opt$i)
