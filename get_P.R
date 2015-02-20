library("reshape")

# directory
dir <- "/myDir"

for (i in 1:23)
{
  # load workspace as saved by longGWAS
  load(paste(dir, "myStudy-", i, ".RData", sep = ""))

  # convert the p-values from longGWAS to a data-frame
  ##  longGWAS output
  ##  $ts - Test Statistic
  ##  $ps - P-values
  p <- as.data.frame(as.table(phenos.gwas$ps))
  p[1] <- NULL
  colnames(p)[1] <- "P"
  
  # import the loci (chr and bp) from bim file
  bim <- read.table(paste(dir, "myStudy-", i, ".bim", sep = ""), F, sep = "\t")
  bim[6]<-NULL
  bim[5]<-NULL
  bim[3]<-NULL
  colnames(bim)[1]<-"CHR"
  colnames(bim)[2]<-"SNP"
  colnames(bim)[3]<-"BP"

  # merge 
  snp.p <- cbind(bim, p)

  # Export
  write.table(snp.p, paste(dir, "myStudy-", i, ".p", sep = ""), sep = "\t", quote = F, col.names = F, row.names = F)
}

