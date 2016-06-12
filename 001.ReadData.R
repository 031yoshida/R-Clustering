library(data.table)   # operate large data
library(foreach)      # loop process
library(dplyr)        # collect process
click.data <- as.data.frame(fread("click_data_sample.csv"))
head(click.data)