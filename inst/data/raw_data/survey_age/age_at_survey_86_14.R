
# Set working directory
# setwd()
library(dplyr)
library(tidyr)

survey_age <- read.table('./inst/data/raw_data/survey_age/age_at_survey_86_14.dat', sep=' ')
names(survey_age) <- c('C0000100',
  'C0000200',
  'C0006600',
  'C0006900',
  'C0007020',
  'C0007040',
  'C0007042',
  'C0007044',
  'C0007046',
  'C0007048',
  'C0007050',
  'C0007053',
  'C0007056',
  'C3601200',
  'C3981200',
  'C5524900',
  'C5801200')


# Handle missing values

survey_age[survey_age == -1] = NA  # Refused
survey_age[survey_age == -2] = NA  # Dont know
survey_age[survey_age == -3] = NA  # Invalid missing
survey_age[survey_age == -7] = NA  # Missing


# If there are values not categorized they will be represented as NA

# Use qnames rather than rnums

  names(survey_age) <- c("child_id",
    "mother_id",
    "survey_age_1986",
    "survey_age_1988",
    "survey_age_1990",
    "survey_age_1992",
    "survey_age_1994",
    "survey_age_1996",
    "survey_age_1998",
    "survey_age_2000",
    "survey_age_2002",
    "survey_age_2004",
    "survey_age_2006",
    "survey_age_2008",
    "survey_age_2010",
    "survey_age_2012",
    "survey_age_2014")

survey_age <- survey_age %>%
  gather(key="year", value="survey_age", starts_with("survey_age")) %>%
    mutate(year=str_extract(year, "[0-9]*$")) %>% arrange(mother_id, child_id, year)

save(survey_age, file="./inst/data/raw_data/survey_age.RData")
#********************************************************************************************************

# Remove the '#' before the following line to create a data file called "categories" with value labels.
#categories <- vallabels(new_data)

# Remove the '#' before the following lines to rename variables using Qnames instead of Reference Numbers
#new_data <- qnames(new_data)
#categories <- qnames(categories)

# Produce summaries for the raw (uncategorized) data file
summary(new_data)

# Remove the '#' before the following lines to produce summaries for the "categories" data file.
#categories <- vallabels(new_data)
#summary(categories)

#************************************************************************************************************

