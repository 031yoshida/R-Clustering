click.user.data <-
  click.data %>%  #target to collect
  group_by(user.id) %>% # grouping by userid
  summarise(click.num=length(click.at)) %>% # collect click number
  as.data.frame() %>% # back to data.frame
  arrange(desc(click.num)) %>%  # descend sort by click.num
  mutate(no=1:length(user.id))  # ranking by click.num
#head(click.user.data)

library(ykmeans)
# clustering by click number
click.user.data <-
  ykmeans(click.user.data, "click.num", "click.num", 3)
# number assigned to cluster
table(click.user.data$cluster)

#  Click distribution
ggplot(click.user.data[1:5000,], aes(x=no, y=click.num, col=as.factor(cluster), shape=as.factor(cluster))) +
  geom_line() +
  geom_point() +
  xlab("user") +
  ylab("Clicks") +
  theme_bw() +
  theme(legend.position="none") +
  scale_color_brewer(palette="Paired")