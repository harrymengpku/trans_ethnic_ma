#$ -S /bin/bash
#$ -l h_rt=24:0:0
#$ -l h_vmem=30G,tmem=30G
#$ -cwd
#$ -j y
#$ -N FE_SAS

WD="/SAN/ugi/mdd/trans_ethnic_ma"
# generate METAL script for meta-analysis, SE weighted
cd /SAN/ugi/mdd/trans_ethnic_ma/scripts
bash Metal_FE_script_generator_sas.sh

# run METAL
cd /SAN/ugi/mdd/trans_ethnic_ma/scripts/results
/share/apps/genomics/metal-2011-3-25/metal < /SAN/ugi/mdd/trans_ethnic_ma/scripts/METAL_FE_SAS.txt 

#qc and plotting
R --vanilla --args $WD/results/METAANALYSIS_FE_SAS_1.tbl $WD/results/FE_sas_qced < $WD/scripts/fe_qc_plot.R

