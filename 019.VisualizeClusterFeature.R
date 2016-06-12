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

# Graph click ratio by user/campaign
ggplot(click.data.cast.cluster2.melt,
       aes(x=variable, y=value, col=as.factor(user.id), group=user.id)) +
  geom_line() +
  geom_point() +
  xlab("Campaign") +
  ylab("Click ratio") +
  scale_x_discrete(label="") +
  theme_bw() +
  theme(legend.position="noe")

# Visialize the cluster feature
click.cluster2.summary$cluster <- as.factor(click.cluster2.summary$cluster)
ggplot(click.cluster2.summary,
       aes(x=variable, y=value, col=cluster, group=cluster, shape=cluster)) +
  geom_line() +
  geom_point() +
  scale_x_discrete(label="") +
  theme_bw() +
  theme(legend.position="top") +
  scale_color_brewer(palette="Paired")