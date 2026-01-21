#!/bin/bash
#SBATCH --job-name=download_exceRpt_DB
#SBATCH --time=2:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=4G
#SBATCH --output=exceRpt_DB_download_%j.log
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=sarah.sczelecki@vuw.ac.nz

# Create database directory
DB_DIR=/nesi/nobackup/vuw03876/excerpt-test/exceRpt_DB
mkdir -p ${DB_DIR}
cd ${DB_DIR}

echo "Starting database download at $(date)"
echo "Working directory: $(pwd)"

# Download mouse database (mm10)
echo "Downloading mouse (mm10) database..."
wget http://org.gersteinlab.excerpt.s3-website-us-east-1.amazonaws.com/exceRptDB_v4_mm10_lowmem.tgz

# Extract mouse database
echo "Extracting mouse database..."
tar -xvf exceRptDB_v4_mm10_lowmem.tgz

# Optional: Download human database (hg38) - uncomment if needed
 echo "Downloading human (hg38) database..."
wget http://org.gersteinlab.excerpt.s3-website-us-east-1.amazonaws.com/exceRptDB_v4_hg38_lowmem.tgz

# Optional: Extract human database - uncomment if needed
 echo "Extracting human database..."
 tar -xvf exceRptDB_v4_hg38_lowmem.tgz

echo "Database download and extraction completed at $(date)"
echo "Database contents:"
ls -lh ${DB_DIR}

echo "Done!"
 
