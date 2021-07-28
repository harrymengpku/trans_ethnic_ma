#$ -S /bin/bash
#$ -l h_rt=20:0:0
#$ -l h_vmem=32G,tmem=32G
#$ -cwd
#$ -j y
#$ -N list_biallelic


cd /SAN/ugi/mdd/trans_ethnic_ma/data/
#module load genomics/bcftools/1.9

for i in {1..22}; do 
/share/apps/genomics/bcftools-1.9/bin/bcftools view -m2 -M2 -v snps /SAN/ugi/ukhls/1000G/ALL.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz -Oz -o biallelic.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz
done

zgrep -v "^##" biallelic.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz | cut -f1-5 > 1000G.biallelic.snplist.txt

for i in {2..22}; do
zgrep -v "^##" biallelic.chr$i.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz | cut -f1-5 | tail -n+2 >> 1000G.biallelic.snplist.txt
done
gzip 1000G.biallelic.snplist.txt

# There are one indel, and ~80 multi-allelic variants in the output files.
# Delete them in a R interactive session, with codes similar to reformat_mr_mega.
# Only indels and rows with duplicated chr:pos were deleted
# There are somed rows with duplicated IDs (rsid). For the same ID, they come with different POS value. There lines were not removed.


