#!/bin/bash
#
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --output=whippet
#SBATCH --error=whippet_error
#SBATCH --job-name=whippet
#SBATCH --mem-per-cpu=10G

#Quantification
path=<path_to_fastq_files>
for i in $(cat ${path}/ids)
do
julia whippet-quant.jl -x ./mouse_m39_104.jls -o ./${i}  ${path}/${i}_R1.fastq ${path}/${i}_R2.fastq
done

#Diff. analysis
julia whippet-delta.jl -a <.psi.gz files> -b <.psi.gz files>
