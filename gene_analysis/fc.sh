#!/bin/bash
#
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --output=fc
#SBATCH --job-name=fc
#SBATCH --mem-per-cpu=10G

path=<path to bam files>

for i in $(cat ${path}/ids)
do
featureCounts -p -t gene -g gene_id -a Mus_musculus.GRCm39.104.chr.gtf  -o ${path}/${i}.txt -T 4 ${path}/${i}Aligned.out_sorted.bam
done
