#Quality filter 
#!/bin/bash
## Leandro de Mattos Pereira


#PBS -P du5 
#PBS -q normal
#PBS -l ncpus=16
#PBS -l walltime=2:00:00
#PBS -l mem=16GB
 
#PBS -l jobfs=32 GB
#PBS -l wd
cd $PBS_O_WORKDIR
############################## Script belown for Trimming with Trimmomatic

sample="2019_9817_AdispC_JPH_S1_R1_001.fastq"

trimmer="ILLUMINACLIP:adapter.fa:2:20:7 LEADING:10 SLIDINGWINDOW:4:13 MINLEN:30"
data='/short/du5/lm1947/'
for r1 in $sample; do

     r2=$r1
     r2="${r1/R1/R2}"
     #echo file: $dir$r1 $dir$r2
   
     r1p="${r1/.fastq/.paired.fastq}"
     r1u="${r1/.fastq/.unpaired.fastq}"
     r2p="${r2/.fastq/.paired.fastq}"
     r2u="${r2/.fastq/.unpaired.fastq}"

    # run the trimmomatic command, note the path to the datafiles, $data
   /short/du5/lm1947/anaconda2/bin/trimmomatic PE -threads 20 $data/$r1 $data/$r2 $r1p $r1u $r2p $r2u $trimmer

done
