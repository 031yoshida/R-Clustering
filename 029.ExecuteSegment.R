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