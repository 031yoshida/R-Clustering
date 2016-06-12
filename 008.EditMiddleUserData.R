# extract by campaign
click.data.campaign <-
  click.data %>%
  group_by(user.id, campaign.id) %>%
  summarise(click.num=length(click.at)) %>%
  as.data.frame()

# deploy campaign lengthwise
click.data.cast <- as.data.frame(
  dcast.data.table(data = as.data.table(click.data.campaign),
                   formula = user.id~campaign.id,
                   value.var = "click.num",
                   fun.aggregate = sum)
)

# calculate total click number
click.data.cast$total <- rowSums(click.data.cast[,-1])
head(click.data.cast, 2)