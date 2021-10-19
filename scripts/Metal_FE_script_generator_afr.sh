#!/bin/bash
WD="/SAN/ugi/mdd/trans_ethnic_ma"
grep "afr" $WD/scripts/fe.all.ancestry.in.txt > $WD/scripts/fe.afr.in.txt

echo "SCHEME STDERR" > $WD/scripts/METAL_FE_AFR.txt
echo "STDERR SE" >> $WD/scripts/METAL_FE_AFR.txt
echo "AVERAGEFREQ ON" >> $WD/scripts/METAL_FE_AFR.txt
echo "MINMAXFREQ ON" >> $WD/scripts/METAL_FE_AFR.txt

while IFS= read -r line; do
echo "#NewStudy" >> $WD/scripts/METAL_FE_AFR.txt
echo "MARKERLABEL MARKERNAME" >> $WD/scripts/METAL_FE_AFR.txt
echo "ALLELELABELS EA NEA" >> $WD/scripts/METAL_FE_AFR.txt 
echo "EFFECTLABEL BETA" >> $WD/scripts/METAL_FE_AFR.txt
echo "PVALUELABEL P" >> $WD/scripts/METAL_FE_AFR.txt
echo "FREQLABEL EAF" >> $WD/scripts/METAL_FE_AFR.txt
echo "STDERR SE" >> $WD/scripts/METAL_FE_AFR.txt   
echo "PROCESS $line" >> $WD/scripts/METAL_FE_AFR.txt
done < $WD/scripts/fe.afr.in.txt

echo OUTFILE $WD/results/METAANALYSIS_FE_AFR .tbl >> $WD/scripts/METAL_FE_AFR.txt 
echo "ANALYZE HETEROGENEITY" >> $WD/scripts/METAL_FE_AFR.txt 

