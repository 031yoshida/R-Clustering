click.data.cast1 <- click.data.cast
# valiable for clustering
keys <- names(click.data.cast1)[-c(1,ncol(click.data.cast1))]
# execute clustering
click.data.cast.cluster1 <- ykmeans(click.data.cast1, keys, "total", 3:6)
# confirm number of people in cluster
table(click.data.cast.cluster1$cluster)

library(reshape2)
click.data.cast.cluster1.melt <- melt(
  click.data.cast.cluster1,
  id.vars = c("user.id", "cluster"),
  measure.vars = keys)
click.cluster1.summary <-
  click.data.cast.cluster1.melt %>%
  group_by(cluster, variable) %>%
  summarise(value=mean(value)) %>%
  as.data.frame()