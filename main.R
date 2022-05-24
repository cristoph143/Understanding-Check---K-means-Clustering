setwd(getwd())

# read csv
data <- read.csv("grades.csv",
    header = TRUE,
    sep = "\t"
)
data

# choose k
k <- 3

# use cluster package
library(cluster)

# use kmeans function from cluster package
kmeans <- kmeans(
    data, 
    k, 
    iter.max = 10,
    nstart = 25,
    algorithm = c(
        "Hartigan-Wong", "Lloyd", "Forgy", "MacQueen"
    )
)
kmeans$cluster
fviz_cluster(kmeans, data)
kmeans$size

# import library of factoextra
library(factoextra)

#plot results of final k-means model
s <- fviz_cluster(kmeans, data)
s

# get the cluster centers in kmeans
centers <- kmeans$centers
centers

# save s[["data"]] as csv
write.csv(s[["data"]], "kmean.csv")

# find means of each cluster
aggregate(
    data, 
    by = list(cluster = kmeans$cluster), 
    FUN = mean
)

# add cluster assignment to original data
final_data <- cbind(
    data, 
    kmeans$cluster
)
final_data

