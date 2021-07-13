#$ -S /bin/bash
#$ -l h_rt=24:0:0
#$ -l h_vmem=128G,tmem=128G
#$ -cwd
#$ -j y
#$ -N mr.mega.test2

/SAN/ugi/mdd/MR-MEGA/MR-MEGA -i /SAN/ugi/mdd/trans_ethnic_ma/scripts/mr_mega_test2.in.txt -o mrmega.test2

