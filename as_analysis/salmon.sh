#!/bin/bash

#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --output=salmon
#SBATCH --error=salmon
#SBATCH --job-name=salmon
#SBATCH --mem-per-cpu=15G

path=<path_to_fastq_files>
PATH=$PATH:/nfs/home/users/olga.tsoy/.conda/envs/salmon/bin

for i in $(cat ${path}/ids)
do
salmon quant -i ./mm39_ensembl104_salmon -l IU --numBootstraps 10 -1 ${path}/${i}_R1.fastq  -2 ${path}/${i}_R2.fastq --validateMappings -o ./${i}
done
