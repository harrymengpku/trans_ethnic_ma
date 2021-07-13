#$ -S /bin/bash
#$ -l h_rt=24:0:0
#$ -l h_vmem=60G,tmem=60G
#$ -cwd
#$ -j y
#$ -N mr.mega.manhattan

R --vanilla < /SAN/ugi/mdd/trans_ethnic_ma/scripts/mrmega.test2.manhattan.R
