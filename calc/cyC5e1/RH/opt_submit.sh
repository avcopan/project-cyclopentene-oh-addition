#!/usr/bin/env bash
#SBATCH --job-name=opt-RH
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8GB
#SBATCH --time=24:00:00
#SBATCH --output=opt_orca.out
#SBATCH --error=opt_orca.err

#SBATCH --mail-type=ALL
#SBATCH --mail-user=avcopan@uga.edu

# 1. Load Orca
module load ORCA/6.1.1

# 2. Set up scratch directory
SCRATCH_DIR=/lscratch/${USER}/${SLURM_JOB_ID}
mkdir -p $SCRATCH_DIR

# 3. Copy files from submit directory to scratch directory
cd $SLURM_SUBMIT_DIR
cp *.{inp,xyz,hess} $SCRATCH_DIR/.

# 4. Navigate to scratch directory and run Orca
cd $SCRATCH_DIR
$(which orca) opt.inp

# 5. Copy files back to submit directory and remove scratch directory
cp *.{inp,xyz,hess} $SLURM_SUBMIT_DIR/.
rm -rf $SCRATCH_DIR
