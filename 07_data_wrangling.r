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

## arrange() - sort rows by one/more criteria (columns)

# ascendent (lowest first)
arrange(stats_test, score)

# descendent (highest first)
arrange(stats_test, -score)

# sort by 'interest', then by 'score'
arrange(stats_test, interest, score)

# two criteria
arrange(stats_test, interest, score)

# related: top_n()
top_n(stats_test, 3, interest)
# we received 63 instead of 3 rows, because the highest value
# is shared by 63 students.

# exercises 7.2.4
arrange(profiles, age, body_type)
arrange(stats_test, date_time)
arrange(stats_test, lubridate::parse_date_time(date_time, orders = "dmY HMS"))


## group_by() - group a dataframe by a discrete variable (e.g. 'interest')
by_interest <- group_by(stats_test, interest)
by_interest_and_studtime <- group_by(stats_test, interest, study_time)

# now, we receive a  mean 'score' for every group of 'interest'
summarize(by_interest, mean(score, na.rm = TRUE))

# instead of only one for the whole dataframe
summarize(stats_test, mean(score, na.rm = TRUE))


## summarize() - summarize a column to one value (or one per group)
summarize(by_interest, mn_score = mean(score, na.rm = TRUE))


## n() and count() - count rows
summarize(stats_test, n())
summarize(by_interest, n())

# outside of grouped dataframes, standard R's nrow() is simple/easy
nrow(stats_test)

# count rows, grouped by 'interest'
count(stats_test, interest)

# sort by n
count(stats_test, study_time, sort = TRUE)

# group by 'study_time', them by 'interest'
count(stats_test, study_time, interest)

## pipe ( %>% ) - command chaining
stats_test %>% 
    filter(!is.na(score)) %>% 
    group_by(interest) %>% 
    summarize(mean_score = mean(score)) %>% 
    filter(mean_score > 0.8)


## mutate() - create a new column

stats_test %>% 
    select(bestanden, interest, score) %>% 
    mutate(streber = score > 0.99) %>% 
    filter(streber)

# exercises 7.4
stats_test %>% 
    select(-c(row_number, date_time)) %>% 
    filter(bestanden == "ja") %>% 
    group_by(interest) %>% 
    summarize(points = mean(score), n = n()) %>% 
    filter()

stats_test %>% 
    select(-c(row_number, date_time)) %>% 
    filter(bestanden == "ja") %>% 
    group_by(interest) %>% 
    summarize(points = mean(score), n = n())

stats_test %>% 
    select(score) %>% 
    mutate(mean = mean(score, na.rm = TRUE)) %>% 
    mutate(diff = mean - score) %>% 
    mutate(d2 = diff ^ 2) %>% 
    mutate(md2 = mean(d2, na.rm = TRUE))

stats_test %>% 
    select(score) %>% 
    mutate(score_delta = score - mean(.$score, na.rm = TRUE)) %>% 
    mutate(score_delta_squared = score_delta ^ 2) %>% 
    summarize(score_var = mean(score_delta_squared, na.rm = TRUE)) %>% 
    summarize(sqrt(score_var))

sd(stats_test$score, na.rm = TRUE)


## suffixes
# _if
# mean of all numeric columns
stats_test %>% 
    summarize_if(is.numeric, mean, na.rm = TRUE)

# _all
# sum of NAs for each column
stats_test %>% 
    summarize_all(list(NAs = ~is.na(.) %>% sum))

# min() and max() for each column
stats_test %>%
    summarize_all(list(max = max, min = min), na.rm = TRUE)

# _at
# execute summarize function only for certain columns
stats_test %>% 
    summarize_at(.vars = vars(study_time, self_eval),
                 list(min = min, max = max), na.rm = TRUE)
# same using .funs
stats_test %>% 
    summarize_at(.vars = vars(study_time, self_eval),
                 .funs = funs(min = min, max = max), na.rm = TRUE)

# calculate a proportion to maximum value
stats_test %>% 
    drop_na() %>% 
    mutate_at(.vars = vars(study_time, self_eval, interest),
              .funs = funs(prop = ./max(.))) %>% 
    select(contains("_prop"))


## join() - add columns from another dataframe

# join airline name to flights
flights_joined <- flights %>%
    inner_join(airlines, by = "carrier")

head(flights_joined[, c("year",
                        "month",
                        "day",
                        "carrier",
                        "name",
                        "dep_delay",
                        "arr_delay")])

