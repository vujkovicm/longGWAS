#!/bin/bash
#$ -cwd

#DIRECTORIES
DIR=/myDir

# Estimate the relatedness from all the autosomal SNPs
# lower triangle matrix

/myApps/gcta/gcta64 --bfile ${DIR}/myStudy --autosome --make-grm-gz --out ${DIR}/myStudy --thread-num 30
