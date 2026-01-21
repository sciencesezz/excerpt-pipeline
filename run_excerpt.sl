#This script runs the exceRpt pipeline on pretrimmed fastq files                                                                                                     
#!/bin/bash
#SBATCH --job-name=exceRpt_batch
#SBATCH --time=6:00:00
#SBATCH --cpus-per-task=8
#SBATCH --mem=32G
#SBATCH --output=excerpt_%j.log
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sarah.sczelecki@vuw.ac.nz
# Load Apptainer module
module load Apptainer/1.3.1
# Set project paths
PROJECT_DIR=/nesi/nobackup/vuw03876/excerpt-test
FASTQ_DIR=${PROJECT_DIR}/trimmed-fastq-renamed
OUTPUT_DIR=${PROJECT_DIR}/output
DB_DIR=${PROJECT_DIR}/exceRpt_DB
CONTAINER=${PROJECT_DIR}/excerpt_latest.sif
ADAPTER="none"
SPECIES="mm10"  # Mouse genome (use "hg38" for human)
# Make directories if they don't exist
mkdir -p ${OUTPUT_DIR}
mkdir -p ${DB_DIR}
# Loop over all FASTQ files
for f in ${FASTQ_DIR}/*.fastq.gz; do
    # Get just the filename without path
    filename=$(basename $f)
    # Get sample name without .fastq.gz extension
    sample=$(basename $f .fastq.gz)
    
    echo "Processing sample: $sample"
    echo "Input file: $filename"
    
    # Run exceRpt in Apptainer
    # Don't create per-sample output folder - exceRpt creates its own structure
    apptainer run --bind ${FASTQ_DIR}:/exceRptInput --bind ${OUTPUT_DIR}:/exceRptOutput --bind ${DB_DIR}:/exceRpt_DB ${CONTAINER} INPUT_FILE_PATH=/exceRptInput/${filename} MAIN_ORGANISM_GENOME_ID=${SPECIES} ADAPTER_SEQ=${ADAPTER}
    
    echo "Finished processing: $sample"
    echo "---"
done
echo "All samples processed!"
 
