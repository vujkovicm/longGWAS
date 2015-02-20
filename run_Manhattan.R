library("ggplot2")
library("qqman")

# directory 
setwd("/myDir")

# import the output file as generated from get_P.R
add<-read.table("myStudy.p", F)
colnames(add)[1]<-"CHR"
colnames(add)[2]<-"SNP"
colnames(add)[3]<-"BP"
colnames(add)[4]<-"P"

# manhattan plot
png(file="pheno.png", width = 900, height = 350)
manhattan(add, main = "Phenotype Info", ylim = c(0, 10), cex = 0.6, 
    cex.axis = 0.9, col = c("blue4", "orange3"), suggestiveline = T, genomewideline = T, 
    chrlabs = c(1:20, "P", "Q"))
dev.off()

# qq-plot
png(file="pheno-qq.png", width = 350, height = 350)
qq(add$P, main = "Q-Q plot: Phenotype ", xlim = c(0, 7), ylim = c(0, 12), pch = 18, col = "blue4", cex = 1.5, las = 1)
dev.off()
