#!/bin/bash
WD="/SAN/ugi/mdd/trans_ethnic_ma"
grep "his" $WD/scripts/fe.all.ancestry.in.txt > $WD/scripts/fe.his.in.txt

echo "SCHEME STDERR" > $WD/scripts/METAL_FE_HIS.txt
echo "STDERR SE" >> $WD/scripts/METAL_FE_HIS.txt
echo "AVERAGEFREQ ON" >> $WD/scripts/METAL_FE_HIS.txt
echo "MINMAXFREQ ON" >> $WD/scripts/METAL_FE_HIS.txt

while IFS= read -r line; do
echo "#NewStudy" >> $WD/scripts/METAL_FE_HIS.txt
echo "MARKERLABEL MARKERNAME" >> $WD/scripts/METAL_FE_HIS.txt
echo "ALLELELABELS EA NEA" >> $WD/scripts/METAL_FE_HIS.txt 
echo "EFFECTLABEL BETA" >> $WD/scripts/METAL_FE_HIS.txt
echo "PVALUELABEL P" >> $WD/scripts/METAL_FE_HIS.txt
echo "FREQLABEL EAF" >> $WD/scripts/METAL_FE_HIS.txt
echo "STDERR SE" >> $WD/scripts/METAL_FE_HIS.txt   
echo "PROCESS $line" >> $WD/scripts/METAL_FE_HIS.txt
done < $WD/scripts/fe.his.in.txt

echo OUTFILE $WD/results/METAANALYSIS_FE_HIS_ .tbl >> $WD/scripts/METAL_FE_HIS.txt 
echo "ANALYZE HETEROGENEITY" >> $WD/scripts/METAL_FE_HIS.txt 
echo "CLEAR" >> $WD/scripts/METAL_FE_HIS.txt
echo "QUIT" >> $WD/scripts/METAL_FE_HIS.txt
