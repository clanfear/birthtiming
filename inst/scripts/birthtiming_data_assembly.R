library(dplyr)
source("./R/birthtiming_functions.R")

#------------------------------------
load("./inst/data/raw_data/birth_and_childcare.RData")
load("./inst/data/raw_data/difficulty.RData")
load("./inst/data/raw_data/education.RData")
load("./inst/data/raw_data/grandparents.RData")
load("./inst/data/raw_data/income.RData")
load("./inst/data/raw_data/smoke_drink.RData")
load("./inst/data/raw_data/spanking.RData")
load("./inst/data/raw_data/poverty.RData")
load("./inst/data/raw_data/child_health.RData")
load("./inst/data/raw_data/survey_age.RData")


birthtiming_long_data <- birth_and_childcare %>%
  left_join(smoke_drink, by=c("child_id", "mother_id")) %>%
  left_join(education, by=c("mother_id", "child_id")) %>%
  left_join(survey_age, by=c("mother_id", "child_id", "year")) %>%
  left_join(difficulty, by=c("child_id", "mother_id", "year")) %>%
  left_join(child_health, by=c("child_id", "mother_id", "year")) %>%
  left_join(spanking, by=c("child_id", "mother_id", "year")) %>%
  left_join(grandparents, by=c("mother_id", "child_id", "year")) %>%
  left_join(income, by=c("mother_id", "year")) %>%
  left_join(poverty, by=c("mother_id", "year")) %>%
  arrange(mother_id, child_id, year) %>%
  filter(as.numeric(year) %% 2 ==0) # dropping intervening years... for now


#---------------------------

save(birthtiming_long_data, file="./inst/data/derived_data/birthtiming_long_data.RData")
