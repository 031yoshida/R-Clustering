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

ggplot(click.data.cast.cluster1.melt, 
       aes(x=variable, y=value, col=as.factor(user.id), group=user.id)) +
  geom_line() +
  geom_point() +
  xlab("Campaign") +
  ylab("Click num") +
  scale_x_discrete(label="") +
  theme_bw() +
  theme(legend.position="noe")

# Clustering by click number of campaign by user
click.cluster1.summary$cluster <- as.factor(click.cluster1.summary$cluster)
ggplot(click.cluster1.summary,
       aes(x=variable, y=value, col=cluster, group=cluster, shape=cluster)) +
  geom_line(lwd=1) +
  geom_point(size=4) +
  xlab("Campaign") +
  ylab("Click num") +
  scale_x_discrete(label="") +
  theme_bw() +
  theme(legend.position="top") +
  scale_color_brewer(palette = "Paired")

# summary campaign by cluster & user
ggplot(click.data.cast.cluster1.melt,
       aes(x=variable, y=value, col=as.factor(user.id), group=user.id)) +
  geom_line() +
  geom_point() +
  xlab("Campaign") +
  ylab("Click num") +
  scale_x_discrete(label="") +
  facet_grid(cluster~.) +
  theme_bw() +
  theme(legend.position="noe")

# calculate average click number by Cluster/User/Campaign
click.cluster1.summary2 <-
  click.data.cast.cluster1 %>%
  group_by(cluster) %>%
  summarise(click.avg=mean(total)) %>%
  as.data.frame()

# Graph the above average
ggplot(click.cluster1.summary2,
       aes(x=cluster, y=click.avg)) +
  geom_bar(stat = "identity", fill="grey") +
  theme_bw()