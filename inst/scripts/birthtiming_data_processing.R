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
  filter(birth_order < 10) %>% # Dropping births past 9th
  arrange(mother_id, dob_year, dob_month) %>%
  mutate(birth_order=case_when(
    mother_id==6671 & dob_year==1980 ~ 1,
    mother_id==6671 & dob_year==1985 ~ 2,
    mother_id==6671 & dob_year==1987 ~ 3,
    mother_id==6671 & dob_year==1989 ~ 4,
    mother_id==6671 & dob_year==1990 ~ 5,
    mother_id==6671 & dob_year==1994 ~ 6,
    TRUE ~ as.double(birth_order)
  ))

birthtiming_long_data %>% filter(mother_id==6671) %>%
  distinct(mother_id, child_id, dob_month, dob_year, death_year, birth_order)
# VARIABLE CREATION

birthtiming_long_data <- birthtiming_long_data %>%
  mutate(serious_health = ifelse(treatment %in% 1 | equipment %in% 1 | medicine %in% 1, 1, 0)) %>%
  mutate(grandparent = ifelse(gdad_present %in% 1 | gmom_present %in% 1, 1, 0)) %>%
  mutate(multibirth = ifelse(n_multiple_birth > 1, 1, 0)) %>%
  mutate(sex = as.integer(sex))

#-----------------------------------------------------------------------------------
# DIFFICULTY SUBSAMPLE
birthtiming_difficulty_diff <- birthtiming_long_data %>%
  filter(!is.na(difficulty)) %>% # only interested in observations with difficulty
  group_by(mother_id, dob_month, dob_year) %>%
  sample_n(1) %>% # Randomly select one of the twins, then use a twin dummy control
  ungroup() %>%
  group_by(child_id) %>%
  slice(1L) %>% # Get first observation of child
  ungroup() %>%
  mutate(known_diff=1)

########################
# Note we do not want a twin of the above children!
# Add code to filter out identical DOB
# Crude approach: paste all ids together, compare
# Seems to work?
#######################

check_vals <- paste(birthtiming_difficulty_diff$mother_id, birthtiming_difficulty_diff$dob_month, birthtiming_difficulty_diff$dob_year)

birthtiming_difficulty_nodiff <- birthtiming_long_data %>%
  filter(child_id %!in% birthtiming_difficulty_diff$child_id) %>% # only interested in observations with difficulty
  mutate(check_val = paste(mother_id, dob_month, dob_year)) %>%
  filter(check_val %!in% check_vals) %>%
  select(-check_val) %>%
  group_by(mother_id, dob_month, dob_year) %>%
  sample_n(1) %>% # Randomly select one of the twins, then use a twin dummy control
  ungroup() %>%
  group_by(child_id) %>%
  slice(1L) %>% # Get first observation of child
  ungroup() %>%
  mutate(known_diff=0)

birthtiming_difficulty <- birthtiming_difficulty_diff %>%
  bind_rows(birthtiming_difficulty_nodiff) %>%
  group_by(mother_id) %>%
  # filter(n() > 1) %>% # Only want mothers with > 1 child
  filter(birth_order < 5) %>% # grabbing first two children... for now
  mutate(child_n = row_number()) %>%
  select(mother_id, child_n, birth_order, sex, m_age_at_birth, difficulty, gestation_wks,
         birthweight_oz, breastfeeding, childcare_binary_yr1, drinking,
         smoking_binary, highest_grade, serious_health, spanking, income, poverty,
         multibirth, survey_age, known_diff) %>%
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
