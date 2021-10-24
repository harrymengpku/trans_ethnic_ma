#!/bin/bash
WD="/SAN/ugi/mdd/trans_ethnic_ma"
grep "eas" $WD/scripts/fe.all.ancestry.in.txt > $WD/scripts/fe.eas.in.txt

echo "SCHEME STDERR" > $WD/scripts/METAL_FE_EAS.txt
echo "STDERR SE" >> $WD/scripts/METAL_FE_EAS.txt
echo "AVERAGEFREQ ON" >> $WD/scripts/METAL_FE_EAS.txt
echo "MINMAXFREQ ON" >> $WD/scripts/METAL_FE_EAS.txt

while IFS= read -r line; do
echo "#NewStudy" >> $WD/scripts/METAL_FE_EAS.txt
echo "MARKERLABEL MARKERNAME" >> $WD/scripts/METAL_FE_EAS.txt
echo "ALLELELABELS EA NEA" >> $WD/scripts/METAL_FE_EAS.txt 
echo "EFFECTLABEL BETA" >> $WD/scripts/METAL_FE_EAS.txt
echo "PVALUELABEL P" >> $WD/scripts/METAL_FE_EAS.txt
echo "FREQLABEL EAF" >> $WD/scripts/METAL_FE_EAS.txt
echo "STDERR SE" >> $WD/scripts/METAL_FE_EAS.txt   
echo "PROCESS $line" >> $WD/scripts/METAL_FE_EAS.txt
done < $WD/scripts/fe.eas.in.txt

echo OUTFILE $WD/results/METAANALYSIS_FE_EAS_ .tbl >> $WD/scripts/METAL_FE_EAS.txt 
echo "ANALYZE HETEROGENEITY" >> $WD/scripts/METAL_FE_EAS.txt 
echo "CLEAR" >> $WD/scripts/METAL_FE_EAS.txt
echo "QUIT" >> $WD/scripts/METAL_FE_EAS.txt
