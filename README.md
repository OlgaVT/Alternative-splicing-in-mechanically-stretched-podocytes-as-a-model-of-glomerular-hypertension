# Alternative splicing in mechanically stretched podocytes as a model of glomerular hypertension

This repository contains the description of the computational pipeline and scripts for RNA-Seq data analysis used in the study.

## RNA-Seq data

Low-stretch (5-6 mm) podocytes experiments:

| name | condition |
| --- | --- |
| 21Jun133_B05 | stretched |
| 21Jun133_C05 | stretched |
| 21Jun133_A05 |  unstretched |
| 21Jun133_E05 | stretched |
| 21Jun133_F05 | stretched |
| 21Jun133_D05 |  unstretched |
| 21Jun133_A06 | stretched |
| 21Jun133_H05 | stretched |
| 21Jun133_G05 | unstretched |

High-stretch experiment

| name | condition |
| --- | --- |
| 21Jun133_C06 | stretched |
| 21Jun133_B06 | unstretched |
| 21Jun133_E06 | stretched |
| 21Jun133_D06 | unstretched |
| 21Jun133_G06 | stretched |
| 21Jun133_F06 | unstretched |

## RNA-Seq data preprocessing

RNA-Seq raw reads for low-stretch, high-stretch, and unstretched podocytes were mapped to the mouse reference genome mm39 with the genome annotation from Ensembl version 104 using **STAR  version 2.7.5c**. We used the default parameters with a 2-pass mode recommended for alternative splicing analysis. The corresponding script is *./gene_analysis/STAR.sh*.

The resulting sam files were converted to bam files, sorted, and indexed using **samtools 1.19**. The corresponding script is *./gene_analysis/samtools.sh*.

Gene read counts were obtained by the **featureCounts** tool included in the **Subread 2.0.0**. The corresponding script is *./gene_analysis/fc.sh*.

## Gene expression analysis

Read counts were further normalized and used for differential gene expression by **DESeq2 version 1.38.3**. The script is *./gene_analysis/DESeq2.R*.

## AS analysis
For isoform switch analysis, we prepared transcript counts using **salmon version 1.9.0** with the transcript annotation based on Ensembl version 104. The script is *./as_analysis/salmon.sh*.

Then we ran the R package **IsoformSwitchAnalyzeR version 1.20.0** with the DESeq2 algorithm. The script is *./as_analysis/ISA.R*.

For alternative splicing analysis, we used **MAJIQ version 2.3**, **leafcutter version 0.2.9**, **rMATS version 4.1.2**, and **Whippet version 0.11.1 (with julia 1.6.6)** with the default parameters. The scripts are in *./as_analysis/*. We defined significantly differentially used events as events with a p-value < 0.05 (for leafcutter, rMATS, and Whippet) or a confidence > 0.95 (for MAJIQ).
