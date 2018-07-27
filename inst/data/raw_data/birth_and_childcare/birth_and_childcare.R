
# Set working directory
# setwd()


birth_and_childcare <- read.table('./inst/data/raw_data/birth_and_childcare/birth_and_childcare.dat', sep=' ')
names(birth_and_childcare) <- c('C0000100',
  'C0000200',
  'C0005400',
  'C0005500',
  'C0005700',
  'C0005701',
  'C0005702',
  'C0005800',
  'C0007000',
  'C0328000',
  'C0328600',
  'C0338500',
  'C0356400',
  'C0357200')


# Handle missing values

birth_and_childcare[birth_and_childcare == -1] = NA  # Refused
birth_and_childcare[birth_and_childcare == -2] = NA  # Dont know
birth_and_childcare[birth_and_childcare == -3] = NA  # Invalid missing
birth_and_childcare[birth_and_childcare == -7] = NA  # Missing


# If there are values not categorized they will be represented as NA


birth_and_childcare$C0005400 <- factor(birth_and_childcare$C0005400,
    levels=c(1.0,2.0),
    labels=c("MALE",
      "FEMALE"))

names(birth_and_childcare) <- c("child_id",
  "mother_id",
  "sex",
  "dob_month",
  "dob_year",
  "death_month",
  "death_year",
  "birth_order",
  "m_age_at_birth",
  "gestation_wks",
  "birthweight_oz",
  "breastfeeding",
  "childcare_binary_yr1",
  "childcare_months_yr1"
)

save(birth_and_childcare, file="./inst/data/raw_data/birth_and_childcare.RData")
