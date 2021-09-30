#$ -S /bin/bash
#$ -l h_rt=24:0:0
#$ -l h_vmem=15G,tmem=15G
#$ -cwd
#$ -j y
#$ -N fe_his_plot

WD="/SAN/ugi/mdd/trans_ethnic_ma"
R --vanilla  < $WD/scripts/lat_fe_plot.R

