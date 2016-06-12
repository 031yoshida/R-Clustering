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

# extract data of Middle user
target.click.user <-
  click.user.data %>%
  filter(cluster >= 2)
# filter upper Middle from original data
click.data <-
  click.data %>%
  filter(user.id %in% target.click.user$user.id)
