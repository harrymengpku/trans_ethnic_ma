#$ -S /bin/bash
#$ -l h_rt=24:0:0
#$ -l h_vmem=40G,tmem=40G
#$ -cwd
#$ -j y
#$ -N FE_N

/share/apps/genomics/metal-2011-3-25/metal < /SAN/ugi/mdd/trans_ethnic_ma/scripts/METAL_FE_N.txt
