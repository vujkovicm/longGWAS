#!/bin/bash
#$ -cwd

# (chr x 23)
for i in {1..23}
do
    # export plink data to transform and make it longGWAS compatible 
    qsub chr_recodeA.sh $i
    # make .snps file for longGWAS 
    qsub chr_transform.sh $i
done

# merge chr into genome for kinship calculations
qsub snp_chr2genome.sh

# run kinship with GCTA (genome x 1)
qsub run_gcta.sh

# run longGWAS in R (chr x 23)
R CMD BATCH run_longGWAS.R

# transform longGWAS output to SNP-CHR-BP-P format (chr x 23)
R CMD BATCH get_P.R

# merge chr to genome file 
qsub p_chr2genome.sh

# run manhattan and qq-plots (genome x 1)
R CMD BATCH run_Manhattan.R
