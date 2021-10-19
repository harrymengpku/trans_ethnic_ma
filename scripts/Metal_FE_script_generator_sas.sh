#!/bin/bash
WD="/SAN/ugi/mdd/trans_ethnic_ma"
grep "sas" $WD/scripts/fe.all.ancestry.in.txt > $WD/scripts/fe.sas.in.txt

echo "SCHEME STDERR" > $WD/scripts/METAL_FE_SAS.txt
echo "STDERR SE" >> $WD/scripts/METAL_FE_SAS.txt
echo "AVERAGEFREQ ON" >> $WD/scripts/METAL_FE_SAS.txt
echo "MINMAXFREQ ON" >> $WD/scripts/METAL_FE_SAS.txt

while IFS= read -r line; do
echo "#NewStudy" >> $WD/scripts/METAL_FE_SAS.txt
echo "MARKERLABEL MARKERNAME" >> $WD/scripts/METAL_FE_SAS.txt
echo "ALLELELABELS EA NEA" >> $WD/scripts/METAL_FE_SAS.txt 
echo "EFFECTLABEL BETA" >> $WD/scripts/METAL_FE_SAS.txt
echo "PVALUELABEL P" >> $WD/scripts/METAL_FE_SAS.txt
echo "FREQLABEL EAF" >> $WD/scripts/METAL_FE_SAS.txt
echo "STDERR SE" >> $WD/scripts/METAL_FE_SAS.txt   
echo "PROCESS $line" >> $WD/scripts/METAL_FE_SAS.txt
done < $WD/scripts/fe.sas.in.txt

echo OUTFILE $WD/results/METAANALYSIS_FE_SAS .tbl >> $WD/scripts/METAL_FE_SAS.txt 
echo "ANALYZE HETEROGENEITY" >> $WD/scripts/METAL_FE_SAS.txt 

