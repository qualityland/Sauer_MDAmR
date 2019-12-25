library(mosaic)
library(tidyverse)
library(stringr)
library(car)

data(stats_test, package = "pradadata")
data(flights, package = "nycflights13")
data(profiles, package = "okcupiddata")
data(airlines, package = "nycflights13")

## filter() - filter rows by one/multiple criteria

# input: data.frame, output: data.frame
df_women <- filter(profiles, sex == "f")
class(df_women)

# input: tibble, output: tibble
df_failed <- filter(stats_test, bestanden == "nein")
class(df_failed)

# two criteria
df_old_women <- filter(profiles, age > 70, sex == "f")
df_old_women2 <- filter(profiles, age > 70 & sex == "f")
all(df_old_women == df_old_women2, na.rm = TRUE)

df_nosmoke_nodrinks <- filter(profiles, smokes == "no" & drinks == "not at all")
glimpse(df_nosmoke_nodrinks)

# between bounderies
df_middleaged <- filter(profiles, between(age, 35, 60))
summary(df_middleaged$age)

# dplyr::filter vs. base R
# filter
filter(profiles, age > 70, sex == "f", drugs == "sometimes")
# base R
profiles[profiles$age > 70 & profiles$sex == "f" & profiles$drugs == "sometimes",]

## select() - select columns

select(stats_test, score)
select(stats_test, score, study_time)
select(stats_test, score:study_time)

vars <- c("score", "study_time")
select(stats_test, one_of(vars))

## arrange() - sort columns

