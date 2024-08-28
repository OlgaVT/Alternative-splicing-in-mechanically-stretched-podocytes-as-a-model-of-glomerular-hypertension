#!/bin/bash
#
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --output=majiq.txt
#SBATCH --job-name=majiq
#SBATCH --mem-per-cpu=5G

majiq build -j 10 -o ./majiq -c config.txt Mus_musculus.GRCm39.104.chr.gff3
majiq deltapsi -j 10 -o . -grp1 <majiq files> -grp2 <majiq files> -n CONDITION1 CONDITION2
