variable.data <-
  as.data.frame(rbind_all(foreach(k=3:6) %do% {
    # execute clustering
    cluster.data1 <-
      ykmeans(click.data.cast1, keys, "total", k)[,c("user.id", "cluster")]
    cluster.data2 <-
      ykmeans(click.data.cast2, keys, "total", k)[,c("user.id", "cluster")]
    cluster.data3 <-
      ykmeans(click.data.cast3.pc, pc.keys, "total", k)[,c("user.id", "cluster")]
    cluster.data1$cluster.type <- sprintf("size.%s.cluster", k)
    cluster.data2$cluster.type <- sprintf("prop.%s.cluster", k)
    cluster.data3$cluster.type <- sprintf("pca.%s.cluster", k)
    rbind_all(list(cluster.data1, cluster.data2, cluster.data3))
  }))
variable.data.cast <- as.data.frame(
  dcast.data.table(data = as.data.table(variable.data),
                   formula = user.id~cluster.type,
                   value.var = "cluster")
)
head(variable.data.cast)

# create cvrdata
cv.data <- as.data.frame(fread("cv_data_sample.csv"))
target.cv.data <-
  cv.data %>%
  group_by(user.id) %>%
  summarise(cv.num=length(cv.at)) %>%
  as.data.frame()
target.cvr.data <-
  as.data.frame(
    merge(as.data.table(target.click.user[,c("user.id","click.num")]),
          as.data.table(target.cv.data),
          by="user.id",
          all.x=T))
target.cvr.data[is.na(target.cvr.data)] <- 0
target.cvr.data$cvr <- target.cvr.data$cv.num / target.cvr.data$click.num

# conbine cluster
target.data <-
  as.data.frame(
    merge(as.data.table(variable.data.cast),
          as.data.table(target.cvr.data[,c("user.id", "cvr")]),
          by="user.id",
          all.x=T))
target.data[is.na(target.data)] <- 0