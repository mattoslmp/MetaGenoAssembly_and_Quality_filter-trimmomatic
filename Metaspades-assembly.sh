#!/bin/bash
## Leandro de Mattos Pereira

#PBS -P du5
#PBS -q normal
#PBS -l ncpus=16
#PBS -l walltime=24:00:00
#PBS -l mem=128GB

#PBS -l jobfs=100GB
#PBS -l wd
cd $PBS_O_WORKDIR

ls * | grep "R1" >> filename.txt
input="/short/du5/lm1947/TESTE-script/filename.txt"

metaspades="-o results_ASSEMBLY -m 800 -k auto --phred-offset auto"
data='/short/du5/lm1947/dataset_helena/'


while IFS= read -r line
do
for r1 in $line; do

     r2=$r1

     r2="${r1/R1/R2}"
#     echo file: $r1
 #    echo file: $r2
      #echo file: $dir$r1 $dir$r2
   metaspades.py -1 $data/$r1 -2 $data/$r2 $metaspades
done

