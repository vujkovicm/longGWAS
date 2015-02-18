#!/bin/bash
#$ -cwd

FILE=$1

#DIRECTORIES
DIR=/myDir

# Estimate the relatedness from all the autosomal SNPs
# lower triangle matrix

/myApps/gcta/gcta64 --bfile ${DIR}/${FILE}/${FILE}-eur-qc --autosome --make-grm-gz --out ${DIR}/${FILE}/${FILE}-eur-qc --thread-num 30
