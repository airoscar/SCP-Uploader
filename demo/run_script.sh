#!/bin/bash
#SBATCH --time=0:01:00
#SBATCH --job-name=python_script
#SBATCH --mem=16G
echo 'Running'
python -u script.py
echo 'Script complete'