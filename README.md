# GWAS on longitudinal data (multiple time point measurements of a phenotype)
# The protocol is the following, if you want to use longGWAS mixed effects.

#!/bin/bash
#$ -cwd

for i in {1..23}
do
    qsub chr_recodeA.sh $i
    qsub chr_transform.sh $i
done

qsub gen_tped2bed.sh
qsub gen_gcta.sh
R CMD BATCH longGWAS.R
