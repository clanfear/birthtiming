
# Set working directory
# setwd()
library(dplyr)
library(tidyr)

smoke_drink <- read.table('./inst/data/raw_data/smoke_drink/smoke_drink_xrnd.dat', sep=' ')
names(smoke_drink) <- c('C0000100',
  'C0000200',
  'C0005300',
  'C0005400',
  'C0005700',
  'C0320200',
  'C0320400',
  'C0320500',
  'Y2267000')


# Handle missing values

smoke_drink[smoke_drink == -1] = NA  # Refused
smoke_drink[smoke_drink == -2] = NA  # Dont know
smoke_drink[smoke_drink == -3] = NA  # Invalid missing
smoke_drink[smoke_drink == -7] = NA  # Missing



smoke_drink$C0320500 <- factor(smoke_drink$C0320500,
                          levels=c(0.0,1.0,2.0,3.0),
                          labels=c("DID NOT SMOKE",
                                   "LESS THAN 1 PACK A DAY",
                                   "1 OR MORE BUT LESS THAN 2",
                                   "2 OR MORE PACKS A DAY"))

names(smoke_drink) <- c("child_id",
               "mother_id",
               "race",
               "sex",
               "yob",
               "drinking",
               "smoking_binary",
               "smoking_ordinal",
               "VERSION_R26 CHILD/YOUNG ADULT XRND"
)

smoke_drink <- smoke_drink %>%
  select(child_id, mother_id, drinking, smoking_binary, smoking_ordinal)

save(smoke_drink, file="./inst/data/raw_data/smoke_drink.RData")
