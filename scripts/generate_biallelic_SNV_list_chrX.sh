#$ -S /bin/bash
#$ -l h_rt=20:0:0
#$ -l h_vmem=32G,tmem=32G
#$ -cwd
#$ -j y
#$ -N list_biallelic_chrX

# generate biallelic list of SNPs for chrmosome X and merge it with autosomal list of biallelic SNPs.
cd /SAN/ugi/mdd/trans_ethnic_ma/data/

/share/apps/genomics/bcftools-1.9/bin/bcftools view -m2 -M2 -v snps /SAN/ugi/ukhls/1000G/ALL.chrX.phase3_shapeit2_mvncall_integrated_v1b.20130502.genotypes.vcf.gz -Oz -o biallelic.chrX.phase3_shapeit2_mvncall_integrated_v1b.20130502.genotypes.vcf.gz
zgrep -v "^##" biallelic.chrX.phase3_shapeit2_mvncall_integrated_v1b.20130502.genotypes.vcf.gz | cut -f1-5 | tail -n+2 > 1000G.biallelic.chrX.snplist.txt
gzip 1000G.biallelic.chrX.snplist.txt

