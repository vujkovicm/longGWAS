#!/bin/bash
#$ -cwd

# directory
DIR=/myDir

PREFIX=${DIR}/myStudy
EXT=.tped

# plink
PLINK=/myApps/plink-1.07-x86_64/plink

# merge all chromosome-seperated tped and tfam into 1
cat ${PREFIX}-1${EXT} ${PREFIX}-2${EXT} ${PREFIX}-3${EXT} ${PREFIX}-4${EXT} ${PREFIX}-5${EXT} ${PREFIX}-6${EXT} ${PREFIX}-7${EXT} ${PREFIX}-8${EXT} ${PREFIX}-9${EXT} ${PREFIX}-10${EXT} ${PREFIX}-11${EXT} ${PREFIX}-12${EXT} ${PREFIX}-13${EXT} ${PREFIX}-14${EXT} ${PREFIX}-15${EXT} ${PREFIX}-16${EXT} ${PREFIX}-17${EXT} ${PREFIX}-18${EXT} ${PREFIX}-19${EXT} ${PREFIX}-20${EXT} ${PREFIX}-21${EXT} ${PREFIX}-22${EXT} ${PREFIX}-23${EXT} > ${PREFIX}${EXT}

cp ${DIR}/myStudy-1.tfam ${DIR}/myStudy.tfam

# take tped and tfam and convert to bed 
 $PLINK --noweb \
 --tfile ${DIR}/$PREFIX \
 --make-bed \
 --out ${DIR}/$PREFIX

# remove chromosome seperated data now
rm -f ${PREFIX}-*.tped
rm -f ${PREFIX}-*.tfam
rm -f ${PREFIX}-*.log
rm -f ${PREFIX}-*.nosex
