library(ggplot2) 
ggplot(click.user.data[1:5000,], aes(x=no, y=click.num)) +
  geom_line() +
  geom_point() +
  xlab("user") +
  ylab("Clicks") +
  theme_bw()