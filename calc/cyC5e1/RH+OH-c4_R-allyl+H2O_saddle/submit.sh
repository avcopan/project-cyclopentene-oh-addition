#!/usr/bin/env bash
#SBATCH --job-name=allyl
#SBATCH --partition=batch
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=8GB
#SBATCH --time=24:00:00
#SBATCH --output=orca.out
#SBATCH --error=orca.err

#SBATCH --mail-type=ALL
#SBATCH --mail-user=avcopan@uga.edu

module load ORCA/6.1.1

$(which orca) opt.inp
