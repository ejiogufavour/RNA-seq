#!/bin/bash

#SBATCH --partition=pibu_el8
#SBATCH --mail-user=favour.ejiogu@students.unibe.ch
#SBATCH --mail-type=start,end,fail
#SBATCH --job-name="RNAseq MultiQC"
#SBATCH --mem-per-cpu=1000MB
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --error=.logs/errors/%x_%j.err
#SBATCH --output=.logs/outputs/%x_%j.out



WORKDIR=/data/users/fejiogu/RNA-seq
CONTAINTER=$WORKDIR/containers/fastqc-0.12.1.sif
DATADIR=$WORKDIR/raw_data
OUTDIR=$WORKDIR/results/summary

mkdir -p $OUTDIR

module load  MultiQC/1.11-foss-2021a

multiqc -o $OUTDIR $WORKDIR/results