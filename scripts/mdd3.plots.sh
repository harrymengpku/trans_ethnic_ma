#$ -S /bin/bash
#$ -l h_rt=24:0:0
#$ -l h_vmem=60G,tmem=60G
#$ -cwd
#$ -j y
#$ -N plots

WD="/SAN/ugi/mdd/trans_ethnic_ma"
R --vanilla --slave --args $WD/data/eur_mdd3_reformatted.txt.gz $WD/results/mdd3.qqPlot.png < $WD/scripts/qqPlot.R
R --vanilla --slave --args $WD/data/eur_mdd3_reformatted.txt.gz $WD/results/mdd3.manhattan.png < $WD/scripts/manhattanPlot.R
