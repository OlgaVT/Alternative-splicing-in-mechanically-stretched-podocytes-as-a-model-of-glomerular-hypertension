conda activate rmats

#!/bin/bash
#
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --output=rmats
#SBATCH --job-name=rmats
#SBATCH --mem-per-cpu=5G

path=<path_to_rMATS_output_folder>

rmats.py --b1 ${path}/CONDITION1.txt --b2 ${path}/CONDITION2.txt --gtf Mus_musculus.GRCm39.104.chr.gtf -t paired --readLength 101 --nthread 10 --od ${path}  --tmp ${path}/tmp
