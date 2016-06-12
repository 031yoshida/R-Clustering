click.data.cast3 <- click.data.cast
click.data.cast3[,keys] <- click.data.cast3[,keys] / click.data.cast3$total
# PCA Principal Component Analysis
click.data.cast3.pc <-
  as.data.frame(prcomp(click.data.cast3[,keys], scale=T)$x)
click.data.cast3.pc$user.id <- click.data.cast3$user.id
click.data.cast3.pc$total <- click.data.cast3$total
pc.keys <- names(click.data.cast3.pc)[1:length(keys)]
# execute clustering
click.data.cast.cluster3 <- ykmeans(click.data.cast3.pc, pc.keys, "total", 3:6)
table(click.data.cast.cluster3$cluster)
# calculate the average campaign by cluster
click.data.cast3$cluster <- click.data.cast.cluster3$cluster
click.data.cast.cluster3.melt <- melt(
  click.data.cast3,
  id.vars = c("user.id", "cluster"),
  measure.vars = keys)
click.cluster3.summary <-
  click.data.cast.cluster3.melt %>%
  group_by(cluster, variable) %>%
  summarise(value=mean(value)) %>%
  as.data.frame()