#!/bin/bash


editalicefile() {
  local filename="runALICE.sh"  # Set the file to edit

  # Replace & add SLURM SBATCH parameters
  perl -i -pe '
    s/^#SBATCH --nodes=\d+/#SBATCH --partition=cpu-medium\n#SBATCH --nodelist=node[1-20]\n#SBATCH --nodes=1/;
    s/^#SBATCH --ntasks-per-node=\d+/#SBATCH --ntasks-per-node=3\n#SBATCH --cpus-per-task=2/;
    s/^#SBATCH --time=\d+-\d+:\d+:\d+/#SBATCH --time=0-10:00:00/;
  ' "$filename"

  # Change qdynp and qfep binary locations GALBA -> ALICE
  perl -i -pe 's|/home/s2004267/bin/Q|/home/s2004267/data1/bin/Q|g' "$filename"

}




setupdir=$(pwd)

for w_fepdir in $setupdir/1.water/*/; do
  cd "$w_fepdir/inputfiles"

  echo "editing runALICE.sh in $(pwd)"

  cp "runALICE.sh" "runALICE.sh.ORIGINAL"
  editalicefile

for p_fepdir in $setupdir/2.protein/*/; do
  cd "$p_fepdir/inputfiles"

  echo "editing runALICE.sh in $(pwd)"

  cp "runALICE.sh" "runALICE.sh.ORIGINAL"
  editalicefile
