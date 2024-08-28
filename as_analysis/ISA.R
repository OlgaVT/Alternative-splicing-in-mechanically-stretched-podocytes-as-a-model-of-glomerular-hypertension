library(IsoformSwitchAnalyzeR)

quant <- importIsoformExpression(
    parentDir = <path_to_salmon_results>,
    addIsofomIdAsColumn = TRUE,
    readLength = 101
)

myDesign <-  data.frame(
sampleID = colnames(quant$abundance)[-1],
condition = gsub('_.*', '', colnames(quant$abundance)[-1])
)

switchList <- importRdata(
isoformCountMatrix   = quant$counts,
designMatrix         = myDesign,
isoformRepExpression = quant$abundance,
isoformNtFasta = "Mus_musculus.GRCm39.104.transcripts.fa",
isoformExonAnnoation = "Mus_musculus.GRCm39.104.chr.gtf",
showProgress = TRUE,
ignoreAfterPeriod = TRUE) #to ignore versions in transcript ids

switchListFiltered = preFilter(switchList)

#DexSeq
switchListAnalyzed <- isoformSwitchTestDEXSeq(switchListFiltered,
reduceToSwitchingGenes=FALSE)

switchListAnalyzedORF <- analyzeORF(switchListAnalyzed)

#DexSeq
top <- extractTopSwitches(
    switchListAnalyzed, 
    n = NA, 
    extractGenes = FALSE #isoforms are returned
)
write.csv(top, "output.csv")
switchPlotTopSwitches(
switchListAnalyzedORF,
fileType = "pdf",
n = Inf, #Inf for all
splitFunctionalConsequences = FALSE)

save.image(file="output.RData") 
