#!/bin/bash
#SBATCH --job-name=trim_fastq
#SBATCH --time=4:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --output=trim_fastq_%j.log
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sarah.sczelecki@vuw.ac.nz

# -------------------------------
# Load cutadapt module
# -------------------------------
module load cutadapt/4.4-gimkl-2022a-Python-3.11.3

# -------------------------------
# Project directories
# -------------------------------
PROJECT_DIR=/nesi/nobackup/vuw03876/excerpt-test
RAW_FASTQ_DIR=${PROJECT_DIR}/raw-data/R1_reads_all
TRIMMED_DIR=${PROJECT_DIR}/trimmed-fastq
mkdir -p ${TRIMMED_DIR}

# Known adapter sequence for small RNA
ADAPTER_SEQ="TGGAATTCTCGGGTGCCAAGG"

# -------------------------------
# Loop over all FASTQ files
# -------------------------------
for f in ${RAW_FASTQ_DIR}/*.fastq.gz; do
    sample=$(basename $f .fastq.gz)
    echo "Trimming sample: $sample"

    trimmed_fastq=${TRIMMED_DIR}/${sample}.trimmed.fastq.gz

    # Run cutadapt
    cutadapt -a ${ADAPTER_SEQ} -g GGGGGGGGGGGGGGGGGGGG -m 15 -o ${trimmed_fastq} ${f} > ${TRIMMED_DIR}/${sample}.cutadapt.log 2>&1

    echo "Finished trimming: $sample"
done

echo "All samples trimmed! Trimmed FASTQs are in ${TRIMMED_DIR}"

 
