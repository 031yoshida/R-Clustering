# convert number to ratio
click.data.cast2 <- click.data.cast
click.data.cast2[,keys] <- click.data.cast2[,keys] / click.data.cast2$total
# execute clustering
click.data.cast.cluster2 <- ykmeans(click.data.cast2, keys, "total", 3:6)
table(click.data.cast.cluster2$cluster)

# calculate average click number of campaign
click.data.cast.cluster2.melt <- melt(
  click.data.cast.cluster2,
  id.vars = c("user.id","cluster"),
  measure.vars = keys)
click.cluster2.summary <-
  click.data.cast.cluster2.melt %>%
  group_by(cluster, variable) %>%
  summarise(value=mean(value)) %>%
  as.data.frame()