# Intrafamily Model of Sibling Behavior Problems
# 7-14-2018
#-----------------------------------------------------------------------------------
library(dplyr)
library(stringr)
library(tidyr)
library(reshape2)
load("./inst/data/derived_data/birthtiming_long_data.RData")
source("./R/birthtiming_functions.R")
#-----------------------------------------------------------------------------------
# Redoing everything
# So, what do we want it to look like?
# 1) Each observation is a FAMILY
#  1a) Mother-specific variables are first columns
#  2b) Child-specific columns are repeated for each child... up to how many?

#-----------------------------------------------------------------------------------

# MULTIPLE BIRTHS
birthtiming_long_data <- birthtiming_long_data %>%
  left_join(
    birthtiming_long_data %>%
     select(child_id, mother_id, dob_month, dob_year) %>%
     distinct(child_id, .keep_all = T) %>%
     group_by(mother_id, dob_month, dob_year) %>%
     mutate(n_multiple_birth = ifelse(n() > 1, n(), 0)) %>%
     ungroup() %>%
     select(child_id, n_multiple_birth),
    by="child_id") %>%
  arrange(birth_order) %>%
  filter(birth_order < 10) # Dropping births past 9th

# VARIABLE CREATION

birthtiming_long_data <- birthtiming_long_data %>%
  mutate(serious_health = ifelse(treatment %in% 1 | equipment %in% 1 | medicine %in% 1, 1, 0)) %>%
  mutate(grandparent = ifelse(gdad_present %in% 1 | gmom_present %in% 1, 1, 0)) %>%
  mutate(multibirth = ifelse(n_multiple_birth > 1, 1, 0)) %>%
  mutate(sex = as.integer(sex))

#-----------------------------------------------------------------------------------
# DIFFICULTY SUBSAMPLE

birthtiming_difficulty <- birthtiming_long_data %>%
  filter(!is.na(difficulty)) %>% # only interested in observations with difficulty
  group_by(mother_id, dob_month, dob_year) %>%
  sample_n(1) %>% # Randomly select one of the twins, then use a twin dummy control
  ungroup() %>%
  group_by(child_id) %>%
  slice(1L) %>% # Get first observation of child
  ungroup() %>%
  group_by(mother_id) %>%
  filter(n() > 1) %>% # Only want mother's with > 1 child
  slice(1:3) %>% # grabbing first two children... for now
  mutate(child_n = row_number()) %>%
  select(mother_id, child_n, birth_order, sex, m_age_at_birth, difficulty, gestation_wks,
         birthweight_oz, breastfeeding, childcare_binary_yr1, drinking,
         smoking_binary, highest_grade, serious_health, spanking, income, poverty,
         multibirth, survey_age) %>%
  melt(id.vars=c("mother_id", "child_n")) %>%
  mutate(variable = str_c(variable, "_", child_n)) %>%
  dcast(mother_id ~ variable) %>%
  mutate_at(vars(starts_with("highest_grade")), funs(as.factor)) %>%
  mutate_all(funs(as.integer))

birthtiming_difficulty_std <- birthtiming_difficulty %>%
  mutate_at(vars(
    starts_with("birthweight"),
    starts_with("difficulty"),
    starts_with("gestation"),
    starts_with("income"),
    starts_with("m_age_at_birth"),
    starts_with("highest_grade"),
    starts_with("survey_age")
                 ), funs(standardize))
#-----------------

save(birthtiming_difficulty, file="./inst/data/derived_data/birthtiming_difficulty.RData")
save(birthtiming_difficulty_std, file="./inst/data/derived_data/birthtiming_difficulty_std.RData")

# SYNTAX THAT MAY BE USEFUL LATER

# Children that died
# birthtiming_long_data  %>% group_by(child_id) %>% summarize(!all(is.na(death_year)))
