#$ -S /bin/bash
#$ -l h_rt=24:0:0
#$ -l h_vmem=15G,tmem=15G
#$ -cwd
#$ -j y
#$ -N FE_HIS

/share/apps/genomics/metal-2011-3-25/metal < /SAN/ugi/mdd/trans_ethnic_ma/scripts/lat_fe_stderr.txt

