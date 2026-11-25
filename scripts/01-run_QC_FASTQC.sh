#!/bin/bash

#SBATCH --partition=pibu_el8
#SBATCH --mail-user=favour.ejiogu@students.unibe.ch
#SBATCH --mail-type=start,end,fail
#SBATCH --job-name="RNAseq QC"
#SBATCH --mem-per-cpu=1000MB
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00
#SBATCH --error=.logs/errors/%x_%j.err
#SBATCH --output=.logs/outputs/%x_%j.out
#SBATCH --array=0-14

SAMPLE_LIST=(SRR7821949
SRR7821950
SRR7821951
SRR7821952
SRR7821953
SRR7821954
SRR7821955
SRR7821956
SRR7821957
SRR7821968
SRR7821969
SRR7821970
SRR7821971
SRR7821972
SRR7821973)

WORKDIR=/data/users/fejiogu/RNA-seq
CONTAINTER=$WORKDIR/containers/fastqc-0.12.1.sif
DATADIR=$WORKDIR/raw_data
OUTDIR=$WORKDIR/results/${SAMPLE_LIST[$SLURM_ARRAY_TASK_ID]}/FASTQC

mkdir -p $OUTDIR

apptainer exec --bind $WORKDIR --pwd $WORKDIR $CONTAINTER \
    fastqc "$DATADIR/${SAMPLE_LIST[$SLURM_ARRAY_TASK_ID]}_1.fastq.gz" \
        "$DATADIR/${SAMPLE_LIST[$SLURM_ARRAY_TASK_ID]}_2.fastq.gz" -o $OUTDIR
