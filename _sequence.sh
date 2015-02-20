#!/bin/bash
#$ -cwd

# plink export and manual transform (chr x 23)
for i in {1..23}
do
    # export plink data with recodeA option
    qsub chr_bed2raw.sh $i
    # transform .raw to .snps file for longGWAS 
    qsub chr_raw2snps.sh $i
done

# merge chr into genome for kinship calculations
qsub chr2gen_tped2bed.sh

# run kinship with GCTA (genome x 1)
qsub run_gcta.sh

# run longGWAS in R (chr x 23)
R CMD BATCH run_longGWAS.R

# transform longGWAS output to SNP-CHR-BP-P format (chr x 23)
R CMD BATCH get_P.R

# merge chr to genome file 
qsub chr2gen_p.sh

# run manhattan and qq-plots (genome x 1)
R CMD BATCH run_Manhattan.R
