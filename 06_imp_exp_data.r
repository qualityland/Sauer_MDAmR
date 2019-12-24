library(tidyverse)

# load data from R packages
install.packages("okcupiddata")
data(profiles, package = "okcupiddata")
glimpse(profiles)

# read data from csv file
test_score <- read_csv("./data/stats_test.csv")
glimpse(test_score)

# read GERMAN data from csv file
test_score_DE <- read_csv2("./data/stats_test_DE.csv")
glimpse(test_score_DE)

# same data? yes!
all(test_score == test_score_DE, na.rm = TRUE)

# read data from github
# with readr::read_csv()
prada_stats_test_url <-
    paste0("https://raw.github.com/",     # domain
           "sebastiansauer/",             # user
           "Praxis_der_Datenanalyse/",    # project
           "master/",                     # variante
           "data/stats_test.csv")         # folder/file
stats_test <- read_csv(prada_stats_test_url)
glimpse(stats_test)
attributes(stats_test)

# read_csv returns a tibble
# (that returns a tibble, when subsetting ONE column)
class(stats_test[, c("self_eval", "score")])       # tibble
class(stats_test[, "self_eval"])                   # tibble

stats_test_df <- as.data.frame(stats_test)
class(stats_test_df[, c("self_eval", "score")])    # data.frame
class(stats_test_df[, "self_eval"])                # vector!
