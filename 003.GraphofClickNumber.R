click.user.data <-
  click.data %>%  #target to collect
  group_by(user.id) %>% # grouping by userid
  summarise(click.num=length(click.at)) %>% # collect click number
  as.data.frame() %>% # back to data.frame
  arrange(desc(click.num)) %>%  # descend sort by click.num
  mutate(no=1:length(user.id))  # ranking by click.num
#head(click.user.data)

library(ggplot2) #package for graph
ggplot(click.user.data, aes(x=no, y=click.num)) +
  geom_line() +
  geom_point() +
  xlab("user") +
  ylab("Clicks") +
  theme_bw()