
# Set working directory
# setwd()
library(dplyr)
library(tidyr)

grandparents <- read.table('./inst/data/raw_data/grandparents/gmom_gdad_present_79_14.dat', sep=' ')
names(grandparents) <- c('C0000100',
  'C0000200',
  'C0090400',
  'C0090500',
  'C0093500',
  'C0093600',
  'C0096600',
  'C0096700',
  'C0099700',
  'C0099800',
  'C0102800',
  'C0102900',
  'C0105900',
  'C0106000',
  'C0109000',
  'C0109100',
  'C0112100',
  'C0112200',
  'C0117300',
  'C0117400',
  'C0120400',
  'C0120500',
  'C0123800',
  'C0123900',
  'C0127000',
  'C0127100',
  'C0127429',
  'C0127430',
  'C0127629',
  'C0127630',
  'C0127829',
  'C0127830',
  'C0127929',
  'C0127930',
  'C0128029',
  'C0128030',
  'C1989100',
  'C1989200',
  'C2495100',
  'C2495200',
  'C2522900',
  'C2523000',
  'C2793400',
  'C2793500',
  'C3102900',
  'C3103000',
  'C3605200',
  'C3605300',
  'C3985200',
  'C3985300',
  'C5529100',
  'C5529200',
  'C5805400',
  'C5805500')


# Handle missing values

grandparents[grandparents == -1] = NA  # Refused
grandparents[grandparents == -2] = NA  # Dont know
grandparents[grandparents == -3] = NA  # Invalid missing
grandparents[grandparents == -7] = NA  # Missing


names(grandparents) <- c("child_id",
  "mother_id",
  "gmom_present_1979",
  "gdad_present_1979",
  "gmom_present_1980",
  "gdad_present_1980",
  "gmom_present_1981",
  "gdad_present_1981",
  "gmom_present_1982",
  "gdad_present_1982",
  "gmom_present_1983",
  "gdad_present_1983",
  "gmom_present_1984",
  "gdad_present_1984",
  "gmom_present_1985",
  "gdad_present_1985",
  "gmom_present_1986",
  "gdad_present_1986",
  "gmom_present_1987",
  "gdad_present_1987",
  "gmom_present_1988",
  "gdad_present_1988",
  "gmom_present_1989",
  "gdad_present_1989",
  "gmom_present_1990",
  "gdad_present_1990",
  "gmom_present_1991",
  "gdad_present_1991",
  "gmom_present_1992",
  "gdad_present_1992",
  "gmom_present_1993",
  "gdad_present_1993",
  "gmom_present_1994",
  "gdad_present_1994",
  "gmom_present_1996",
  "gdad_present_1996",
  "gmom_present_1998",
  "gdad_present_1998",
  "gmom_present_2000",
  "gdad_present_2000",
  "gmom_present_2002",
  "gdad_present_2002",
  "gmom_present_2004",
  "gdad_present_2004",
  "gmom_present_2006",
  "gdad_present_2006",
  "gmom_present_2008",
  "gdad_present_2008",
  "gmom_present_2010",
  "gdad_present_2010",
  "gmom_present_2012",
  "gdad_present_2012",
  "gmom_present_2014",
  "gdad_present_2014"
)

grandparents <- grandparents %>%
  select(order(colnames(.))) %>%
  select(child_id, mother_id, everything())

grandfather <- grandparents %>%
  select(child_id, mother_id, starts_with("gdad")) %>%
  gather(key="year", value="gdad_present", starts_with("gdad")) %>%
  mutate(year=str_extract(year, "[0-9]*$")) %>% arrange(mother_id, child_id, year)

grandmother <- grandparents %>%
  select(child_id, mother_id, starts_with("gmom")) %>%
  gather(key="year", value="gmom_present", starts_with("gmom")) %>%
  mutate(year=str_extract(year, "[0-9]*$")) %>% arrange(mother_id, child_id, year)

grandparents <- grandfather %>%
  full_join(grandmother, by=c("child_id", "mother_id", "year"))

save(grandparents, file="./inst/data/raw_data/grandparents.RData")
