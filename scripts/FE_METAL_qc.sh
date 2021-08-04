#$ -S /bin/bash
#$ -l h_rt=24:0:0
#$ -l h_vmem=128G,tmem=128G
#$ -cwd
#$ -j y
#$ -N FE_qc

WD="/SAN/ugi/mdd/trans_ethnic_ma"
R --vanilla  < $WD/scripts/FE_METAL_qc.R

