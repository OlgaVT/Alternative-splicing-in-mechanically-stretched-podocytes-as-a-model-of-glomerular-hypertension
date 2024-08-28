#!/bin/bash
#
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --output=samtools
#SBATCH --job-name=samtools
#SBATCH --mem-per-cpu=8G

path=<path_to_sam_files>

for i in $(cat ${path}/ids)
do
samtools view -@ 10 -b -S -h ${path}/${i}Aligned.out.sam > ${path}/${i}Aligned.out.bam
samtools sort  -@ 10 ${path}/${i}Aligned.out.bam > ${path}/${i}Aligned.out_sorted.bam
samtools index ${path}/${i}Aligned.out_sorted.bam
rm ${path}/${i}Aligned.out.bam
done
