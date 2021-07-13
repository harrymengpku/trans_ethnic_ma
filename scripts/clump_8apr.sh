#$ -S /bin/bash
#$ -l h_rt=3:0:0
#$ -l h_vmem=60G,tmem=60G
#$ -cwd
#$ -j y
#$ -N clump
/share/apps/R-3.5.2/bin/R --vanilla --slave --args Howard_EAS_N_rsids_qced_pos_revised_sig_250k_unknowns.txt Howard_EAS_N_rsids_qced_pos_revised_sig_250k_unknowns_clumped.txt 250000 < /SAN/ugi/mdd/chinese_ma/revision1/scripts/clump_gwas_sig.R


