#!/bin/bash
#
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --output=star
#SBATCH --job-name=star
#SBATCH --mem-per-cpu=8G

path=<path_to_fastq_files>

for i in $(cat ${path}/ids); #the file "ids" contains the names of all fastq files to align
do
STAR  --runThreadN 20   --genomeDir ./star_index_m39/ --readFilesIn ${path}/${i}_R1.fastq ${path}/${i}_R2.fastq --outFileNamePrefix ${path}/${i} --outSAMstrandField intronMotif --outSAMattributes NH HI AS nM NM XS --sjdbGTFfile  Mus_musculus.GRCm39.104.chr.gtf --twopassMode Basic;
done
