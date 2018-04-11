# Intrafamily Model of Sibling Behavior Problems
# 05-16-2016
# Data Management Syntax

#-----------------------------------------------------------------------------------

library(dplyr)
library(stringr)
load("./inst/data/raw_data/NLSY_mother_temp_051616.RData")

data       <- nlsy_mother$new_data
categories <- nlsy_mother$categories

# rm(nlsy_mother_temp)
#-----------------------------------------------------------------------------------
# Load list of all time variant variable names
# This is a dataframe with columns for each var number and var name for each year.
# The rows represent a given variable, meaning if you want to get every wave of a
# give variable, grab all the names in that variable's row.

# Alternative: Get only the particular vars I need with names as columns
var_nums <- read.csv("./inst/data/raw_data/short_varlist_060416.csv",
                          stringsAsFactors = FALSE, header=TRUE)[seq(1,15,2),]
var_nums      <- apply(var_nums, 2, str_replace, pattern="[.]", replacement="")
rownames(var_nums) <- seq(1986,2000,2)
colnames(var_nums) <- c("Difficulty","Cries_0_12","Cries_12_24")

time_invar_varlist <- read.csv("./inst/data/raw_data/time_invar_varlist_060416.csv",
                               stringsAsFactors = FALSE, header=TRUE)[1:2,]
time_invar_varlist <- apply(time_invar_varlist, 2, str_replace, pattern="[.]",
                            replacement="")
colnames(time_invar_varlist) <- c(
  "child_id",
  "mother_id",
  "race",
  "sex",
  "birth_month",
  "birth_year",
  "m_age_at_birth",
  "prenatal_care",
  "prenatal_month",
  "m_prebirth_weight",
  "m_prepreg_weight",
  "m_weight_change",
  "weight_loss_gain",
  "gestation_time",
  "c_birth_weight_oz",
  "c_low_birth_weight"
)

all_varlist <- c(as.vector(time_invar_varlist[1, c(1,2,7)]),
                 as.vector(var_nums))
all_varlist_names <- c(colnames(time_invar_varlist)[c(1,2,7)],
                       paste("Difficulty",  rownames(var_nums), sep="_"),
                       paste("Cries_0_11",  rownames(var_nums), sep="_"),
                       paste("Cries_12_23", rownames(var_nums), sep="_"))

var_index <- cbind(all_varlist, all_varlist_names)

#-----------------------------------------------------------------------------------
# Assembling Mother-Level Data
#-----------------------------------------------------------------------------------

data_subset <- data %>% select(one_of(all_varlist))

if (all(names(data_subset)==as.vector(var_index[,1]))){
  names(data_subset) <- var_index[,2]
  } else {
    cat("ERROR")
}

data_subset <- data_subset[ifelse(any(!is.na(data_subset[ ,4:27])),TRUE,FALSE), ]

data_all_child <- data_subset %>%
  group_by(mother_id) %>%
  mutate(twins=ifelse(m_age_at_birth %in% m_age_at_birth[duplicated(m_age_at_birth)], 1, 0))

# How to deal with twins?
# If two observations have same mother id and same age at birth, average non-missing values?
# It is worth noting this results in non-integers.
data_twins_only <- data_all_child %>%
  filter(twins==1) %>%
  group_by(mother_id, m_age_at_birth) %>%
  summarize_at(.vars=vars(names(data_all_child)[c(1,4:27)]), funs(mean(., na.rm=TRUE)))
data_twins_only[is.na(data_twins_only)] <- NA # Replacing NaNs
data_twins_only <- as.data.frame(apply(data_twins_only, MARGIN=2, FUN=round, digits=0))

data_all_twins <- bind_rows(data_all_child %>%
                              filter(twins==0) %>%
                              select(-twins),
                            data_twins_only)
data_all_twins <- data_all_twins %>% arrange(child_id)

# First, subset to mothers who have more than one non-twin child.
data_multi_child <- data_all_twins[data_all_twins$mother_id %in%
                    names(table(data_all_twins$mother_id))[table(data_all_twins$mother_id) > 1],]

# Next, subset to first two children of mothers with multiple children.
data_two_child <- data_multi_child %>%
  group_by(mother_id) %>%
  filter(row_number() < 3) %>%
  ungroup()
if(any(table(data_two_child$mother_id) > 2)) stop("Should be only two observations per ID")

# Subset to first and second child
data_first_child <- data_two_child %>% group_by(mother_id) %>% filter(row_number()==1) %>% ungroup()
if(any(table(data_first_child$mother_id) > 1)) stop("Should be only one observation per ID")

data_second_child <- data_two_child %>% group_by(mother_id) %>% filter(row_number()==2) %>% ungroup()
if(any(table(data_second_child$mother_id) > 1)) stop("Should be only one observation per ID")

# Parse first child vars
first_child <- data_first_child %>% mutate(difficulty_1=case_when(
  is.na(Difficulty_1986)==FALSE ~ Difficulty_1986,
  is.na(Difficulty_1988)==FALSE ~ Difficulty_1988,
  is.na(Difficulty_1990)==FALSE ~ Difficulty_1990,
  is.na(Difficulty_1992)==FALSE ~ Difficulty_1992,
  is.na(Difficulty_1994)==FALSE ~ Difficulty_1994,
  is.na(Difficulty_1996)==FALSE ~ Difficulty_1996,
  is.na(Difficulty_1998)==FALSE ~ Difficulty_1998,
  is.na(Difficulty_2000)==FALSE ~ Difficulty_2000,
  TRUE ~ as.numeric(NA)
)) %>%
  mutate(cries_1=NA) %>%
  select(mother_id, m_age_1=m_age_at_birth, difficulty_1, cries_1)

c1_cry_vars <- data_first_child %>% select(contains("Cries"))
for (i in 1:dim(c1_cry_vars)[1]){
  if (any(!is.na(c1_cry_vars[i,]))){
    first_child$cries_1[i] <- as.integer(c1_cry_vars[i, min(which(!is.na(c1_cry_vars[i,])))])
  } else {
    first_child$cries_1[i] <- NA
  }
}

# Parse second child vars
second_child <- data_second_child %>% mutate(difficulty_2=case_when(
  is.na(Difficulty_1986)==FALSE ~ Difficulty_1986,
  is.na(Difficulty_1988)==FALSE ~ Difficulty_1988,
  is.na(Difficulty_1990)==FALSE ~ Difficulty_1990,
  is.na(Difficulty_1992)==FALSE ~ Difficulty_1992,
  is.na(Difficulty_1994)==FALSE ~ Difficulty_1994,
  is.na(Difficulty_1996)==FALSE ~ Difficulty_1996,
  is.na(Difficulty_1998)==FALSE ~ Difficulty_1998,
  is.na(Difficulty_2000)==FALSE ~ Difficulty_2000,
  TRUE ~ as.numeric(NA)
)) %>%
  mutate(cries_2=NA) %>%
  select(mother_id, m_age_2=m_age_at_birth, difficulty_2, cries_2)

c2_cry_vars <- data_second_child %>% select(contains("Cries"))
for (i in 1:dim(c2_cry_vars)[1]){
  if (any(!is.na(c2_cry_vars[i,]))){
    second_child$cries_2[i] <- as.integer(c2_cry_vars[i, min(which(!is.na(c2_cry_vars[i,])))])
  } else {
    second_child$cries_2[i] <- NA
  }
}

analysis_data <- right_join(first_child, second_child, by="mother_id")
if(any(analysis_data$m_age_1 > analysis_data$m_age_2)) stop("A mother cannot be younger at time of first birth than time of second")

# Removing a case with a nonsensical value; 0 on a 1 to 5 scale. This error exists
# in the original data file.
analysis_data <- analysis_data[analysis_data$mother_id!=5232,]
save(analysis_data, file="./Data/analysis_data_060416.RData")

###############################
# PICK UP HERE
###############################

data_difficulty <- analysis_data %>% select(m_age_1, difficulty_1, m_age_2, difficulty_2) %>% filter(complete.cases(.))
data_cries <- analysis_data %>% select(m_age_1, cries_1, m_age_2, cries_2) %>% filter(complete.cases(.))

# Rescaling difficulty
data_difficulty[,c(2,4)] <- data_difficulty[,c(2,4)]/10
data_difficulty <- data_difficulty/10

# Descriptives
cov(data_difficulty[,c(1,3,2,4)])
cor(data_difficulty[,c(1,3,2,4)])
apply(data_difficulty[,c(1,3,2,4)], 2, sd)


barplot(table(data_cries$cries_1))
barplot(table(data_cries$cries_2))
par(mfrow=c(1,2))
barplot(table(data_difficulty$difficulty_1*10), ylim=c(0,100), main="Difficulty (Child 1)")
barplot(table(data_difficulty$difficulty_2*10), ylim=c(0,100), main="Difficulty (Child 2)")

write.csv(data_difficulty, file="./Data/data_difficulty_060416.csv")
write.csv(data_cries, file="./Data/data_cries_060416.csv")
