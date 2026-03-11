#!/usr/bin/env bash
#SBATCH --job-name=sp-c4-allyl-saddle
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=12GB
#SBATCH --time=24:00:00
#SBATCH --output=sp_orca.out
#SBATCH --error=sp_orca.err

#SBATCH --mail-type=ALL
#SBATCH --mail-user=avcopan@uga.edu

echo "Loading orca..."
module load ORCA/6.1.1

echo "Setting up scratch directory..."
SCRATCH_DIR=/lscratch/${USER}/${SLURM_JOB_ID}
mkdir -p $SCRATCH_DIR

echo "Copying files into scratch directory..."
cd $SLURM_SUBMIT_DIR
cp *.{log,inp,xyz,allxyz,hess} $SCRATCH_DIR/.

echo "Navigating to scratch directory..."
cd $SCRATCH_DIR

echo "Running orca on ${hostname} at ${pwd}..."
$(which orca) sp.inp

echo "Copying files back to submit directory..."
cp *.{log,inp,xyz,allxyz,hess} $SLURM_SUBMIT_DIR/.
rm -rf $SCRATCH_DIR
