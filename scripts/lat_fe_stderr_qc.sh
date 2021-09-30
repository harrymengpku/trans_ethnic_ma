#$ -S /bin/bash
#$ -l h_rt=24:0:0
#$ -l h_vmem=40G,tmem=40G
#$ -cwd
#$ -j y
#$ -N fe_his_qc

WD="/SAN/ugi/mdd/trans_ethnic_ma"
R --vanilla  < $WD/scripts/lat_fe_stderr_qc.R

