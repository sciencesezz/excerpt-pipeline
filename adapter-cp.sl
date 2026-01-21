                                                                                       
#!/bin/bash
#SBATCH --job-name=copy_db_files
#SBATCH --time=0:10:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --output=copy_db_%j.log
module load Apptainer/1.3.1
cd /nesi/nobackup/vuw03876/excerpt-test/exceRpt_DB
mkdir adapters
echo "Attempting to copy files from container..."
# Method 1: Direct copy via exec
apptainer exec ../excerpt_latest.sif sh -c 'cat /exceRpt_DB/adapters/adapters.fa' > adapters/adapters.fa 2>&1
apptainer exec ../excerpt_latest.sif sh -c 'cat /exceRpt_DB/randomBits.dat' > randomBits.dat 2>&1
apptainer exec ../excerpt_latest.sif sh -c 'cat /exceRpt_DB/STAR_Parameters_Endogenous_smallRNA.in' > STAR_Parameters_Endogenous_smallRNA.in 2>&1
apptainer exec ../excerpt_latest.sif sh -c 'cat /exceRpt_DB/STAR_Parameters_Exogenous.in' > STAR_Parameters_Exogenous.in 2>&1
echo "Files created:"
ls -lh adapters/adapters.fa
ls -lh *.dat *.in
echo ""
echo "File contents check:"
echo "=== adapters.fa first 10 lines ==="
head -10 adapters/adapters.fa
echo "=== randomBits.dat size ==="
wc -c randomBits.dat
