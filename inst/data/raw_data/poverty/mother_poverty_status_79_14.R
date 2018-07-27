
# Set working directory
# setwd()
library(dplyr)
library(tidyr)

poverty <- read.table('./inst/data/raw_data/poverty/mother_poverty_status_79_14.dat', sep=' ')
names(poverty) <- c('A0002600',
  'R0000100',
  'R0173600',
  'R0214700',
  'R0214800',
  'R0217910',
  'R0406100',
  'R0618500',
  'R0898700',
  'R1144600',
  'R1519800',
  'R1890500',
  'R2257600',
  'R2444900',
  'R2870400',
  'R3074100',
  'R3400800',
  'R3656200',
  'R4006700',
  'R4417800',
  'R5080800',
  'R5166100',
  'R6478800',
  'R7006600',
  'R7703900',
  'R8496300',
  'T0987900',
  'T2210100',
  'T3108000',
  'T4112500',
  'T5022800')


# Handle missing values

poverty[poverty == -1] = NA  # Refused
poverty[poverty == -2] = NA  # Dont know
poverty[poverty == -3] = NA  # Invalid missing
poverty[poverty == -4] = NA  # Valid missing
poverty[poverty == -5] = NA  # Non-interview


# If there are values not categorized they will be represented as NA
poverty$R0173600 <- factor(poverty$R0173600,
                        levels=c(1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0,18.0,19.0,20.0),
                        labels=c("CROSS MALE WHITE",
                                 "CROSS MALE WH. POOR",
                                 "CROSS MALE BLACK",
                                 "CROSS MALE HISPANIC",
                                 "CROSS FEMALE WHITE",
                                 "CROSS FEMALE WH POOR",
                                 "CROSS FEMALE BLACK",
                                 "CROSS FEMALE HISPANIC",
                                 "SUP MALE WH POOR",
                                 "SUP MALE BLACK",
                                 "SUP MALE HISPANIC",
                                 "SUP FEM WH POOR",
                                 "SUP FEMALE BLACK",
                                 "SUP FEMALE HISPANIC",
                                 "MIL MALE WHITE",
                                 "MIL MALE BLACK",
                                 "MIL MALE HISPANIC",
                                 "MIL FEMALE WHITE",
                                 "MIL FEMALE BLACK",
                                 "MIL FEMALE HISPANIC"))

names(poverty) <- c("VERSION_R26_1 2014",
               "mother_id",
               "SAMPLE ID  79 INT",
               "RACE_ETH_COHORT",
               "SEX",
               "poverty_1979",
               "poverty_1980",
               "poverty_1981",
               "poverty_1982",
               "poverty_1983",
               "poverty_1984",
               "poverty_1985",
               "poverty_1986",
               "poverty_1987",
               "poverty_1988",
               "poverty_1989",
               "poverty_1990",
               "poverty_1991",
               "poverty_1992",
               "poverty_1993",
               "poverty_1994",
               "poverty_1996",
               "poverty_1998",
               "poverty_2000",
               "poverty_2002",
               "poverty_2004",
               "poverty_2006",
               "poverty_2008",
               "poverty_2010",
               "poverty_2012",
               "poverty_2014"
)


poverty <- poverty %>%
  select(mother_id,
         starts_with("poverty")) %>%
  gather(key="year", value="poverty", starts_with("poverty")) %>%
  mutate(year=str_extract(year, "[0-9]*$")) %>% arrange(mother_id, year)

save(poverty, file="./inst/data/raw_data/poverty.RData")
