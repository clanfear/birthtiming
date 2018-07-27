
# Set working directory
# setwd()
library(dplyr)
library(tidyr)
library(stringr)

difficulty <- read.table('./inst/data/raw_data/difficulty/difficulty_86_12.dat', sep=' ')
names(difficulty) <- c('C0000100',
  'C0000200',
  'C0005300',
  'C0005400',
  'C0005700',
  'C0572510',
  'C0792910',
  'C0992900',
  'C1193200',
  'C1501000',
  'C1557900',
  'C1793600',
  'C2505200',
  'C2533500',
  'C3616500',
  'C3995300',
  'C5539100',
  'Y2267000')


# Handle missing values

difficulty[difficulty == -1] = NA  # Refused
difficulty[difficulty == -2] = NA  # Dont know
difficulty[difficulty == -3] = NA  # Invalid missing
difficulty[difficulty == -7] = NA  # Missing


names(difficulty) <- c("child_id",
    "mother_id",
    "race",
    "SEX",
    "YOB",
    "difficulty_1986",
    "difficulty_1988",
    "difficulty_1990",
    "difficulty_1992",
    "difficulty_1994",
    "difficulty_1996",
    "difficulty_1998",
    "difficulty_2000",
    "difficulty_2002",
    "difficulty_2008",
    "difficulty_2010",
    "difficulty_2012",
    "VERSION_R26_XRND")

difficulty <- difficulty %>%
  select(-VERSION_R26_XRND, -SEX, -YOB)

difficulty <- difficulty %>%
  gather(key="year", value="difficulty", starts_with("difficulty")) %>%
  mutate(year=str_extract(year, "[0-9]*$")) %>% arrange(mother_id, child_id, year)

save(difficulty, file="./inst/data/raw_data/difficulty.RData")

