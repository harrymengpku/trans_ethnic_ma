#$ -S /bin/bash
#$ -l h_rt=240:0:0
#$ -l h_vmem=128G,tmem=128G
#$ -cwd
#$ -j y
#$ -N primary.analysis

WD="/SAN/ugi/mdd/trans_ethnic_ma"
#/SAN/ugi/mdd/MR-MEGA/MR-MEGA -i $WD/scripts/mr_mega.in.txt --pc 5 -o $WD/results/AFR.EAS.SAS.HIS.MDD3SUM.MRMEGA
#R --vanilla --slave --args $WD/scripts/RE2C.file.list.txt $WD/data/RE2C.in.txt < $WD/scripts/RE2C_data_prepare.R
#bash /SAN/ugi/mdd/RE2C/RE2C.bash --input $WD/data/RE2C.in.txt  --threads 4 --output $WD/results/RE2C.out

# fixed effect MA with Metal, weighted by SE
bash $WD/scripts/Metal_FE_script_generator.sh
/share/apps/genomics/metal-2011-3-25/metal < $WD/scripts/METAL_FE.txt


