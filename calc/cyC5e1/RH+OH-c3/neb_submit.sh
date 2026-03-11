#!/usr/bin/env bash
#SBATCH --job-name=neb-c1-c2
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8GB
#SBATCH --time=24:00:00
#SBATCH --output=neb_orca.out
#SBATCH --error=neb_orca.err

#SBATCH --mail-type=ALL
#SBATCH --mail-user=avcopan@uga.edu

# 1. Load Orca
module load ORCA/6.1.1

# 2. Set up scratch directory
SCRATCH_DIR=/lscratch/${USER}/${SLURM_JOB_ID}
mkdir -p $SCRATCH_DIR

# 3. Copy files from submit directory to scratch directory
cd $SLURM_SUBMIT_DIR
cp *.{log,inp,xyz,allxyz,hess} $SCRATCH_DIR/.

# 4. Navigate to scratch directory and run Orca
cd $SCRATCH_DIR
$(which orca) neb.inp

# 5. Copy files back to submit directory and remove scratch directory
cp *.{log,inp,xyz,allxyz,hess} $SLURM_SUBMIT_DIR/.
rm -rf $SCRATCH_DIR
