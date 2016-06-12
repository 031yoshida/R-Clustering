# convert number to ratio
click.data.cast2 <- click.data.cast
click.data.cast2[,keys] <- click.data.cast2[,keys] / click.data.cast2$total
# execute clustering
click.data.cast.cluster2 <- ykmeans(click.data.cast2, keys, "total", 3:6)
table(click.data.cast.cluster2$cluster)
