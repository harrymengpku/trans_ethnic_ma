#$ -S /bin/bash
#$ -l h_rt=24:0:0
#$ -l h_vmem=128G,tmem=128G
#$ -cwd
#$ -j y
#$ -N primary.analysis

WD="/SAN/ugi/mdd/trans_ethnic_ma"
/SAN/ugi/mdd/MR-MEGA/MR-MEGA -i $WD/scripts/mr_mega.in.txt -o $WD/results/AFR.EAS.SAS.HIS.MDD3SUM.MRMEGA
R --vanilla --args $WD/scripts/mr_mega.in.txt $WD/data/RE2C.in.txt < $WC/scripts/RE2C_data_prepare.R
bash /SAN/ugi/mdd/RE2C/RE2C.bash --input $WD/data/RE2C.in.txt  --output $WD/results/RE2C.out

