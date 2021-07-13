#$ -S /bin/bash
#$ -l h_rt=3:0:0
#$ -l h_vmem=60G,tmem=60G
#$ -cwd
#$ -j y
#$ -N find_sig

R --vanilla --slave --args /SAN/ugi/mdd/chinese_ma/revision1/Howard_EAS_N_rsids_qced_pos_revised.txt /SAN/ugi/mdd/chinese_ma/revision1/Howard_EAS_N_rsids_qced_pos_revised_sig.txt < /SAN/ugi/mdd/chinese_ma/revision1/scripts/find_gw_sig.R

