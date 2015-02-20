#!/bin/bash
#$ -cwd

# transform data into a longGWAS accepted .snps file

# get chr from outside
CHR=$2

# directory
DIR=/myDir

# remove first 6 columns
cut -d " " -f 7- ${DIR}/myStudy-${CHR}.raw > ${DIR}/myStudy-${CHR}.tmp

# remember header (SNP names)
head -n 1 ${DIR}/myStudy-${CHR}.tmp > ${DIR}/myStudy-${CHR}.head

# remove header
sed -i "1d" ${DIR}/myStudy-${CHR}.tmp

# substitute 1 to 0.5, and 2 to 1
sed -i "s/1/0.5/g" ${DIR}/myStudy-${CHR}.tmp
sed -i "s/2/1/g" ${DIR}/myStudy-${CHR}.tmp

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
}' ${DIR}/myStudy-${CHR}.tmp > ${DIR}/myStudy-${CHR}.snps

# remove temporary file
rm ${DIR}/myStudy-${CHR}.tmp
