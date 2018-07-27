
# Set working directory
# setwd()
library(dplyr)
library(tidyr)

child_health <- read.table('./inst/data/raw_data/child_health/child_health_conditions.dat', sep=' ')
names(child_health) <- c('C0000100',
  'C0000200',
  'C0005300',
  'C0005400',
  'C0005700',
  'C0404600',
  'C0404700',
  'C0404800',
  'C0593300',
  'C0593400',
  'C0593500',
  'C0812300',
  'C0812400',
  'C0812500',
  'C1002300',
  'C1002400',
  'C1002500',
  'C1206000',
  'C1206100',
  'C1206200',
  'C1526000',
  'C1526100',
  'C1526200',
  'C1772300',
  'C1772400',
  'C1772500',
  'C2254100',
  'C2254200',
  'C2254300',
  'Y2267000')


# Handle missing values

child_health[child_health == -1] = NA  # Refused
child_health[child_health == -2] = NA  # Dont know
child_health[child_health == -3] = NA  # Invalid missing
child_health[child_health == -7] = NA  # Missing

names(child_health) <- c(
    "child_id",
    "mother_id",
    "race",
    "sex",
    "birth_year",
    "treatment_1986",
    "medicine__1986",
    "equipment_1986",
    "treatment_1988",
    "medicine__1988",
    "equipment_1988",
    "treatment_1990",
    "medicine__1990",
    "equipment_1990",
    "treatment_1992",
    "medicine__1992",
    "equipment_1992",
    "treatment_1994",
    "medicine__1994",
    "equipment_1994",
    "treatment_1996",
    "medicine__1996",
    "equipment_1996",
    "treatment_1998",
    "medicine__1998",
    "equipment_1998",
    "treatment_2000",
    "medicine__2000",
    "equipment_2000",
    "VERSION_R26_XRND")

child_health <- child_health %>%
  select(-race, -sex, -birth_year, -VERSION_R26_XRND)

treatment <- child_health %>%
  select(child_id, mother_id, starts_with("treatment")) %>%
  gather(key="year", value="treatment", starts_with("treatment")) %>%
  mutate(year=str_extract(year, "[0-9]*$")) %>% arrange(mother_id, child_id, year)

equipment <- child_health %>%
  select(child_id, mother_id, starts_with("equipment")) %>%
  gather(key="year", value="equipment", starts_with("equipment")) %>%
  mutate(year=str_extract(year, "[0-9]*$")) %>% arrange(mother_id, child_id, year)

medicine <- child_health %>%
  select(child_id, mother_id, starts_with("medicine")) %>%
  gather(key="year", value="medicine", starts_with("medicine")) %>%
  mutate(year=str_extract(year, "[0-9]*$")) %>% arrange(mother_id, child_id, year)

child_health <- treatment %>%
  full_join(equipment, by=c("mother_id", "child_id", "year")) %>%
  full_join(medicine, by=c("mother_id", "child_id", "year"))

save(child_health, file="./inst/data/raw_data/child_health.RData")
