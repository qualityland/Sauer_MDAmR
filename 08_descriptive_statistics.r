library(mosaic)
library(tidyverse)
library(skimr)
library(lsr)
library(corrr)
library(GGally)
library(sjmisc)

data(stats_test, package = "pradadata")

## mosaic - package that simplyfies data analysis

# syntax:
# verfahren(zielvariable ~ gruppierungsvariable, data = meine_tabelle)
favstats(interest ~ bestanden, data = stats_test) # (default: na.rm = TRUE)
# single variable, grouped by 2nd variable
favstats(score~interest, data = stats_test)
# single variables
favstats(~score, data = stats_test)
# inspect whole dataframes
inspect(stats_test)


## dplyr

stats_nona <- drop_na(stats_test, score)
summarize(
    stats_nona,
    mean = mean(score),
    var = var(score),
    sd = sd(score),
    aad = lsr::aad(score)
)


## skimr

stats_test %>% 
    filter(!is.na(bestanden)) %>% 
    group_by(bestanden) %>% 
    skimr::skim()

dplyr::group_by(iris) %>% 
    skimr::skim()


# relative frequencies

# for one variable
stats_test %>% 
    drop_na() %>% 
    mosaic::tally(~bestanden, data = ., format = "proportion")

# for two variables
stats_test %>% 
    drop_na() %>% 
    filter(interest %in% c(1, 6)) %>% # only the little and very interested
    mosaic::tally(bestanden ~ interest, data = ., format = "proportion")

# proportion differences
stats_test %>% 
    drop_na() %>% 
    filter(interest %in% c(1, 6)) %>% 
    mosaic::diffprop(bestanden ~ interest, data = ., format = "proportion")

# frequencies
stats_test %>% 
    group_by(bestanden) %>% 
    sjmisc::frq(study_time)

# flat_table
stats_test %>% 
    sjmisc::flat_table(bestanden, study_time, margin = "row")

