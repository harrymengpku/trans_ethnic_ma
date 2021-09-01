#$ -S /bin/bash
#$ -l h_rt=20:0:0
#$ -l h_vmem=60G,tmem=60G
#$ -cwd
#$ -j y
#$ -N mr_mega_whishare_new

WD="/SAN/ugi/mdd/trans_ethnic_ma"
# MR-MEGA
echo "Start MR-MEGA analysis."
/SAN/ugi/mdd/MR-MEGA/MR-MEGA -i $WD/scripts/mr_mega.in.txt --pc 3 --print_pcs_and_die -o $WD/results/MRMEGA.WHISHARE.210901
echo "MR-MEGA finished."
echo "=========="

