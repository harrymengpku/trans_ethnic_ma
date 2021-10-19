#$ -S /bin/bash
#$ -l h_rt=24:0:0
#$ -l h_vmem=30G,tmem=30G
#$ -cwd
#$ -j y
#$ -N FE_AFR

WD="/SAN/ugi/mdd/trans_ethnic_ma"
# generate METAL script for meta-analysis, SE weighted
cd /SAN/ugi/mdd/trans_ethnic_ma/scripts
bash Metal_FE_script_generator_afr.sh

# run METAL
cd /SAN/ugi/mdd/trans_ethnic_ma/scripts/results
/share/apps/genomics/metal-2011-3-25/metal < /SAN/ugi/mdd/trans_ethnic_ma/scripts/METAL_FE_AFR.txt 

#qc and plotting
R --vanilla --args $WD/results/METAANALYSIS_FE_AFR_1.tbl $WD/results/FE_afr_qced < $WD/scripts/fe_qc_plot.R

