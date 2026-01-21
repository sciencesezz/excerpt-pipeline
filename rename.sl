#!/bin/bash
#SBATCH --job-name=rename_for_exceRpt
#SBATCH --time=0:30:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --output=rename_%j.log

# Create a new directory for renamed files
mkdir -p /nesi/nobackup/vuw03876/excerpt-test/trimmed-fastq-renamed

cd /nesi/nobackup/vuw03876/excerpt-test/trimmed-fastq

# Create symlinks with simpler names
for f in *.trimmed.fastq.gz; do
    newname=$(echo $f | sed 's/.trimmed.fastq.gz/.fastq.gz/')
    ln -s $(pwd)/$f /nesi/nobackup/vuw03876/excerpt-test/trimmed-fastq-renamed/$newname
    echo "Linked: $f -> $newname"
done

echo "Done! Files are in trimmed-fastq-renamed/"

 
