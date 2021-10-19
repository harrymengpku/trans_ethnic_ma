#!/bin/bash
WD="/SAN/ugi/mdd/trans_ethnic_ma"
echo "SCHEME STDERR" > $WD/scripts/METAL_FE.txt
echo "STDERR SE" >> $WD/scripts/METAL_FE.txt
echo "AVERAGEFREQ ON" >> $WD/scripts/METAL_FE.txt
echo "MINMAXFREQ ON" >> $WD/scripts/METAL_FE.txt

while IFS= read -r line; do
echo "#NewStudy" >> $WD/scripts/METAL_FE.txt
echo "MARKERLABEL MARKERNAME" >> $WD/scripts/METAL_FE.txt
echo "ALLELELABELS EA NEA" >> $WD/scripts/METAL_FE.txt 
echo "EFFECTLABEL BETA" >> $WD/scripts/METAL_FE.txt
echo "PVALUELABEL P" >> $WD/scripts/METAL_FE.txt
echo "FREQLABEL EAF" >> $WD/scripts/METAL_FE.txt
echo "STDERR SE" >> $WD/scripts/METAL_FE.txt   
echo "PROCESS $line" >> $WD/scripts/METAL_FE.txt
done < $WD/scripts/fe.all.ancestry.in.txt

echo OUTFILE $WD/results/METAANALYSIS_FE_ALL_ANCESTRY .tbl >> $WD/scripts/METAL_FE.txt 
echo "ANALYZE HETEROGENEITY" >> $WD/scripts/METAL_FE.txt 

