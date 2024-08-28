# Alternative-splicing-in-mechanically-stretched-podocytes-as-a-model-of-glomerular-hypertension

This repository contains the preprocessed data and the description of the computational pipeline used in the study.

## RNA-Seq data

Low-stretch podocytes experiments:

name condition
B05_L1_S8 stretched
C05_L1_S13 stretched
A05_L1_S3  unstretched
E05_L1_S23 stretched
F05_L1_S28 stretched
D05_L1_S18  unstretched
A06_L1_S4 stretched
H05_L1_S38 stretched
G05_L1_S33 unstretched

High-stretch experiment

name condition
C06_L1_S14 stretched
B06_L1_S9 unstretched
E06_L1_S24 stretched
D06_L1_S19 unstretched
G06_L1_S34 stretched
F06_L1_S29 unstretched

## RNA-Seq data preprocessing

RNA-Seq raw reads for low-stretch, high-stretch, and unstretched podocytes were mapped to the mouse reference genome mm39 with the genome annotation from Ensembl version 104 using STAR version 2.7.5c. We used the default parameters with a 2-pass mode recommended for alternative splicing analysis. The corresponding script is ./gene_analysis/STAR.sh.

The resulting sam files were converted to bam files, sorted, and indexed using samtools 1.19. The corresponding script is ./gene_analysis/samtools.sh.

Gene read counts were obtained by the featureCounts tool included in the Subread 2.0.0. The corresponding script is ./gene_analysis/fc.sh.

The resulting table with raw read counts is ./gene_analysis/podocytes_fc_raw_counts.

## Gene expression analysis

Read counts were further normalized and used for differential gene expression by DESeq2 version 1.38.3. The script is ./gene_analysis/DESeq2.R. The output files from the DESeq2 analysis are in ./gene_analysis/DESeq2.

## AS analysis
For isoform switch analysis, we prepared transcript counts using salmon version 1.9.0 with the transcript annotation based on Ensembl version 104. 
and ran the R package IsoformSwitchAnalyzeR version 1.20.0 [30989184] with the DESeq2 algorithm. For alternative splicing analysis, we used MAJIQ version 2.3 [26829591], leafcutter version 0.2.9 [29229983], rMATS version 4.1.2, and Whippet version 0.11.1 (with julia 1.6.6) [30220560] with the default parameters. We defined significantly differentially used events as events with a p-value < 0.05 (for leafcutter, rMATS, and Whippet) or a confidence > 0.95 (for MAJIQ).
