#!/bin/bash
#SBATCH -N 1
#SBATCH -t 120:00:00
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=xiangrui.meng@ucl.ac.uk

WD="/home/xmeng/trans_ethnic_ma"
# MR-MEGA
echo "Start MR-MEGA analysis."
MR-MEGA -i $WD/scripts/mr_mega.in.txt --pc 3 -o $WD/results/AFR.EAS.SAS.HIS.MDD3SUM.MRMEGA
echo "MR-MEGA finished."
echo "=========="
# fixed effect MA with Metal, weighted by SE (METAL)
echo "Start fixed effect meta-analysis."
bash $WD/scripts/Metal_FE_script_generator.sh
metal < $WD/scripts/METAL_FE.txt
echo "Fixed effect meta-analysis finished."
echo "=========="

# randome effect meta-analysis (RE2C)
echo "Start Random effect meta-analysis."
/sw/arch/Debian10/EB_production/2021/software/R/4.1.0-foss-2021a/bin/R --vanilla --slave --args $WD/scripts/RE2C.file.list.txt $WD/data/RE2C.in.txt < $WD/scripts/RE2C_data_prepare.R
bash /home/xmeng/bin/RE2C/RE2C.bash --input $WD/data/RE2C.in.txt  --threads 4 --output $WD/results/RE2C.out
echo "Random effect meta-analysis finished."
echo "=========="

