
# Set working directory
# setwd()
library(dplyr)
library(tidyr)

income <- read.table('./inst/data/raw_data/income/mother_fam_income_79_14.dat', sep=' ')
names(income) <- c('R0000100',
  'R0217900',
  'R0406010',
  'R0618410',
  'R0898600',
  'R1144500',
  'R1519700',
  'R1890400',
  'R2257500',
  'R2444700',
  'R2870200',
  'R3074000',
  'R3400700',
  'R3656100',
  'R4006600',
  'R4417700',
  'R5080700',
  'R5166000',
  'R6478700',
  'R7006500',
  'R7703700',
  'R8496100',
  'T0987800',
  'T2210000',
  'T3107800',
  'T4112300',
  'T5022600')


# Handle missing values

income[income == -1] = NA  # Refused
income[income == -2] = NA  # Dont know
income[income == -3] = NA  # Invalid missing
income[income == -4] = NA  # Valid missing
income[income == -5] = NA  # Non-interview

names(income) <- c("mother_id",
               "income_1979",
               "income_1980",
               "income_1981",
               "income_1982",
               "income_1983",
               "income_1984",
               "income_1985",
               "income_1986",
               "income_1987",
               "income_1988",
               "income_1989",
               "income_1990",
               "income_1991",
               "income_1992",
               "income_1993",
               "income_1994",
               "income_1996",
               "income_1998",
               "income_2000",
               "income_2002",
               "income_2004",
               "income_2006",
               "income_2008",
               "income_2010",
               "income_2012",
               "income_2014"
)

income <- income %>%
  gather(key="year", value="income", starts_with("income")) %>%
  mutate(year=str_extract(year, "[0-9]*$")) %>% arrange(mother_id, year)

save(income, file="./inst/data/raw_data/income.RData")
