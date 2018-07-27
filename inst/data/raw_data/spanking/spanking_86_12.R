
# Set working directory
# setwd()
library(dplyr)
library(tidyr)

spanking <- read.table('./inst/data/raw_data/spanking/spanking_86_12.dat', sep=' ')
names(spanking) <- c('C0000100',
  'C0000200',
  'C0541800',
  'C0541900',
  'C0752200',
  'C0752300',
  'C0953900',
  'C1152000',
  'C1403200',
  'C1604800',
  'C1945400',
  'C2266500',
  'C2711300',
  'C2987700',
  'C3390200',
  'C3916100',
  'C5167300',
  'C5743800',
  'Y2267000')


# Handle missing values

spanking[spanking == -1] = NA  # Refused
spanking[spanking == -2] = NA  # Dont know
spanking[spanking == -3] = NA  # Invalid missing
spanking[spanking == -7] = NA  # Missing


# If there are values not categorized they will be represented as NA
#
#
# varlabels <- c("ID CODE OF CHILD",
#   "ID CODE OF MOTHER OF CHILD",
#   "HOME A (0-2): MOM HAVE TO SPANK CH IN PAST WK",
#   "HOME A (0-2): #TIMES SPANKED CH IN PAST WK",
#   "HOME A (0-2): MOM HAVE TO SPANK CH IN PAST WK",
#   "HOME A (0-2): #TIMES SPANKED CH IN PAST WK",
#   "HOME A (0-2): #TIMES SPANKED CH IN PAST WK",
#   "HOME A (0-2): #TIMES SPANKED CH IN PAST WK",
#   "HOME A (0-2): #TIMES SPANKED CH IN PAST WK",
#   "HOME A (0-2): #TIMES SPANKED CH IN PAST WK",
#   "HOME A: HOW OFT SPANK CH IN PAST WK 1998",
#   "HOME A (0-2): #TIMES SPANKED CH IN PAST WK 2000",
#   "HOME A (0-2): #TIMES SPANKED CH IN PAST WK 2002",
#   "HOME A (0-2): #TIMES SPANKED CH IN PAST WK 2004",
#   "HOME A (0-2): #TIMES SPANKED CH IN PAST WK 2006",
#   "HOME A (0-2): #TIMES SPANKED CH IN PAST WK 2008",
#   "HOME A (0-2): #TIMES SPANKED CH IN PAST WK 2010",
#   "HOME A (0-2): #TIMES SPANKED CH IN PAST WK 2012",
#   "VERSION_R26 CHILD/YOUNG ADULT XRND"
# )

names(spanking) <- c("child_id",
               "mother_id",
               "spanked_binary_1986",
               "spanked_count_1986",
               "spanked_binary_1988",
               "spanked_count_1988",
               "spanked_1990",
               "spanked_1992",
               "spanked_1994",
               "spanked_1996",
               "spanked_1998",
               "spanked_2000",
               "spanked_2002",
               "spanked_2004",
               "spanked_2006",
               "spanked_2008",
               "spanked_2010",
               "spanked_2012",
               "VERSION_R26 CHILD/YOUNG ADULT XRND"
)

spanking <- spanking %>%
  select(-starts_with("VERSION")) %>%
  mutate(spanked_1986 = case_when(
    is.na(spanked_binary_1986) ~ as.integer(NA),
    spanked_binary_1986==0 ~ as.integer(0),
    spanked_binary_1986==1 ~ as.integer(spanked_count_1986)
    )
  ) %>%
  mutate(spanked_1988 = case_when(
    is.na(spanked_binary_1988) ~ as.integer(NA),
    spanked_binary_1988==0 ~ as.integer(0),
    spanked_binary_1988==1 ~ as.integer(spanked_count_1988)
    )
  ) %>%
  select(-spanked_binary_1986, -spanked_binary_1988,
         -spanked_count_1986,  -spanked_count_1988) %>%
  select(order(colnames(.))) %>%
  gather(key="year", value="spanking", starts_with("spanked")) %>%
  mutate(year=str_extract(year, "[0-9]*$")) %>% arrange(mother_id, year)

save(spanking, file="./inst/data/raw_data/spanking.RData")
