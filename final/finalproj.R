# Biplot great for visualization
library(devtools)
install_github("vqv/ggbiplot")
library(ggbiplot)

library(ISLR)
nci.labs=NCI60$labs  ## NCI data
nci.data=NCI60$data ## Labels
dim(nci.data)

# Scale data to have mean=0 and sd=1 (each gene on same scale)
sd.data = scale(nci.data) #

nci.pca = prcomp(nci.data, center = T, scale. = T)
summary(nci.pca)

write.csv(nci.pca$x, file = "nci60.csv", row.names = F)
write.csv(nci.labs, file="ncilabs.csv", row.names = F)
