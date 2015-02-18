#!/bin/bash
#$ -cwd

# transform data into a longGWAS accepted .snps file

FILE=$1
CHR=$2

#DIRECTORIES
DIR=/mnt/isilon/aplenc/project/gwas/risk/longitudinal

# remove first 6 columns
cut -d " " -f 7- ${DIR}/${FILE}/${FILE}-${CHR}-eur-qc.raw > ${DIR}/${FILE}/${FILE}-${CHR}-eur-qc.tmp

# remember header (SNP names)
head -n 1 ${DIR}/${FILE}/${FILE}-${CHR}-eur-qc.tmp > ${DIR}/${FILE}/${FILE}-${CHR}-eur-qc.head

# remove header
sed -i "1d" ${DIR}/${FILE}/${FILE}-${CHR}-eur-qc.tmp

# substitute 1 to 0.5, and 2 to 1
sed -i "s/1/0.5/g" ${DIR}/${FILE}/${FILE}-${CHR}-eur-qc.tmp
sed -i "s/2/1/g" ${DIR}/${FILE}/${FILE}-${CHR}-eur-qc.tmp

# transpose the dataset
awk '
{
    for (i=1 ; i<=NF; i++)  {
        a[NR, i] = $i
    }
}
NF>p { p=NF }
END {
    for(j=1; j<=p; j++) {
        str = a[1,j]
        for(i=2; i<=NR; i++){
            str = str" "a[i,j];
        }
        print str
    }
}' ${DIR}/${FILE}/${FILE}-${CHR}-eur-qc.tmp > ${DIR}/${FILE}/${FILE}-${CHR}-eur-qc.snps

# remove temporary file
rm ${DIR}/${FILE}/${FILE}-${CHR}-eur-qc.tmp
