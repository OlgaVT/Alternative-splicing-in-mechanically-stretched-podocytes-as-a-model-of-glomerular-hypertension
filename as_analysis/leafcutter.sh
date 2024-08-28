#!/bin/bash
#
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --output=leafcutter
#SBATCH --job-name=leafcutter
#SBATCH --mem-per-cpu=5G

for i in $(ls <path_to_bam_files>); 
do  regtools junctions extract -a 8 -m 50 -s 0 -M 500000 $i -o ${i}.junc; 
echo ${i}.junc >> dcm_juncfiles.txt; 
done

conda activate leafcutter

python ./leafcutter/clustering/leafcutter_cluster_regtools.py -j juncfiles.txt -m 50 -o podocytes -l 500000 --checkchrom
Rscript ./leafcutter/scripts/gtf_to_exons.R Mus_musculus.GRCm39.104.chr.gtf.gz Mus_musculus.GRCm39.104.txt
Rscript ./leafcutter/scripts/leafcutter_ds.R <*_perind_numers.counts.gz> --num_threads 4  group_files.txt  -e Mus_musculus.GRCm39.104.txt -c 10
