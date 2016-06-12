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

# Graph the distribution
click.cluster3.summary$cluster <- as.factor(click.cluster3.summary$cluster)
ggplot(click.cluster3.summary,
       aes(x=variable, y=value, col=cluster, group=cluster, shape=cluster)) +
  geom_line() +
  geom_point(size=4) +
  scale_x_discrete(label="") +
  theme_bw() +
  theme(legend.position="top") +
  scale_color_brewer(palette = "Paired")

# Graph distribution by Cluster/User
ggplot(click.data.cast.cluster3.melt,
       aes(x=variable, y=value, col=as.factor(user.id), group=user.id)) +
  geom_line() +
  geom_point() +
  xlab("Campaign") +
  ylab("Click ratio") +
  scale_x_discrete(label="") +
  facet_grid(cluster~.) +
  theme_bw() +
  theme(legend.position="noe")

# calculate the average
click.cluster3.summary2 <-
  click.data.cast3 %>%
  group_by(cluster) %>%
  summarise(click.avg=mean(total)) %>%
  as.data.frame()
click.cluster3.summary2

# Graph the above average
ggplot(click.cluster3.summary2, aes(x=cluster, y=click.avg)) +
  geom_bar(stat = "identity", fill="grey") +
  theme_bw()
