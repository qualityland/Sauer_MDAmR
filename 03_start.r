## Chapter 3


# download data sets from authors github repository
#devtools::install_github("sebastiansauer/pradadata")


library(pradadata)
?pradadata

url <- "https://raw.githubusercontent.com/sebastiansauer/modar/master/datasets/stats_test.csv"
download.file(url, "./data/stats_test.csv")

stats_test <- read.csv("./data/stats_test.csv")
str(stats_test)
