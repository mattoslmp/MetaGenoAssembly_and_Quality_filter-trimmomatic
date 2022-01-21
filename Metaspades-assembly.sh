#!/bin/bash
## Leandro de Mattos Pereira
#PBS -P du5
#PBS -q normal
#PBS -l ncpus=16
#PBS -l walltime=24:00:00
#PBS -l mem=128GB

#PBS -l jobfs=1TB
#PBS -l wd
cd $PBS_O_WORKDIR

##ls * | grep "R1" >> filename.txt
input="/short/du5/lm1947/data/filename.txt"
# Input is a List with name of files.

trimmer="ILLUMINACLIP:adapter.fa:2:30:10 LEADING:10 SLIDINGWINDOW:4:15 MINLEN:30 HEADCROP:20"
while IFS= read -r line
do
for r1 in $line; do

     r2=$r1

     r2="${r1/R1/R2}"
#     echo file: $r1
 #    echo file: $r2
  r1p="${r1/.fastq/.paired.fastq}"
     r1u="${r1/.fastq/.unpaired.fastq}"
     r2p="${r2/.fastq/.paired.fastq}"
     r2u="${r2/.fastq/.unpaired.fastq}"

    # run the trimmomatic command, note the path to the datafiles, $data
   /short/du5/lm1947/anaconda2/bin/trimmomatic PE -threads 20 $r1 $r2 $r1p $r1u $r2p $r2u $trimmer
done
done < "$input"

/short/du5/lm1947/anaconda2/bin/fastqc -q -t 16 *.fastq -o ./Results_fastqc_FOR_PAIRED_R1_R2_Trimmomatic
