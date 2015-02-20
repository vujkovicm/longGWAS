longGWAS.R

source("/R/x86_64-redhat-linux-gnu-library/2.15/longGWAS/R/longGWAS.R")
library("reshape")

# directory
dir <- "/myDir"

# phenotype
# the dataset cannot contain only missing phenotypes for an individual
# each individual must have at least one measurement
# missing values should be presented as NA
pheno.df <- read.table(paste(dir, "phenotype_no_header_no_id_missing_as_NA.txt", sep = ""), F)
phenos <- as.matrix(pheno.df)
m <- ncol(phenos)

# take output from GCTA matrix and format it as a longGWAS kinship matrix
FillGRMtriangle = function(prefix)
{
        #  read .grm.gz as data frame
        gzFileName = paste(prefix, ".grm.gz", sep = "")
        df <- read.table(gzFileName, sep = "\t", F)

        # remove nr of observations (V3)
        df[3] <- NULL

        # pivot table based on V2
        df.new <- reshape(df, timevar = "V2", idvar = "V1", direction = "wide" )

        # remov identifier
        df.new[1] <- NULL

        # then fill out the upper triangle with values from lower triangle
        for(i in 1:dim(df.new)[1])
        {
                # identity line in the middle is 1
                df.new[i, i] <- 1

                # use symmetry to fill out the values
                for(j in 1:i)
                {
                        df[j, i] <- df[i, j]
                }
        }
        # save as matrix
        matrix.new <- as.matrix(df.new)
        return (matrix.new)
}

# create longGWAS kinship matrix
K <- fillGRMtriangle(paste(dir, "myStudy-GCTA-output", sep = ""))

# chromosome-separated analyses
for (i in 1:23)
{
    	# link tothe genetic files
    	snps <- read.table(paste(dir, "myStudy", i, ".snps", sep = ""))
    	snps.full <- as.matrix(snps)
    	n <- nrow(phenos)
    	phenos.gwas <- longGWAS.gwas(phenos, n, m, K = K, snps = snps.full)
    	# phenos.pred <- longGWAS.predictRandomEffects(phenos, n, m, K, varComps = phenos.gwas)
    	save.image(file = paste(dir, "myStudy", i, ".RData", sep=""))
}
