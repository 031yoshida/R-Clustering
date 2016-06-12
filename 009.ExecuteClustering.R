click.data.cast1 <- click.data.cast
# valiable for clustering
keys <- names(click.data.cast1)[-c(1,ncol(click.data.cast1))]
# execute clustering
click.data.cast.cluster1 <- ykmeans(click.data.cast1, keys, "total", 3:6)
# confirm number of people in cluster
table(click.data.cast.cluster1$cluster)