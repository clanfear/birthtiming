# Intrafamily Model of Sibling Behavior Problems
# 05-16-2016
# Data Management Syntax

#-----------------------------------------------------------------------------------
standardize <- function(x){
  return( (x-mean(x, na.rm=T))/sd(x, na.rm=T) )
}

load_and_format_NLSY <- function(){
  require(dplyr)
  require(stringr)
  require(tidyr)
  require(reshape2)
  load("../data/raw_data/NLSY_mother_temp_051616.RData")

  data       <- nlsy_mother$new_data
  categories <- nlsy_mother$categories

  #-----------------------------------------------------------------------------------
  # Load list of all time variant variable names
  # Getting correct variables from csv files due to NLSY inconsistency.

  var_nums <- read.csv("../data/raw_data/short_varlist_060416.csv",
                       stringsAsFactors = FALSE, header=TRUE)[seq(1,15,2),]
  var_nums           <- apply(var_nums, 2, str_replace, pattern="[.]", replacement="")
  rownames(var_nums) <- seq(1986,2000,2)
  colnames(var_nums) <- c("Difficulty","Cries_0_12","Cries_12_24")

  time_invar_varlist <- read.csv("../data/raw_data/time_invar_varlist_060416.csv",
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

  all_varlist <- c(as.vector(time_invar_varlist[1, ]),
                   as.vector(var_nums))
  all_varlist_names <- c(colnames(time_invar_varlist),
                         paste("Difficulty",  rownames(var_nums), sep="_"),
                         paste("Cries_0_11",  rownames(var_nums), sep="_"),
                         paste("Cries_12_23", rownames(var_nums), sep="_"))

  var_index <- data_frame(varcode=all_varlist, varname=all_varlist_names)

  #---------------------------------------------------------------------------------
  # Assembling Mother-Level Data
  #---------------------------------------------------------------------------------
  data_subset <- data %>% select(one_of(var_index$varcode))

  names(data_subset) <- var_index$varname[match(names(data_subset), var_index$varcode)]

  # End goal is a dataframe that has only first two children of mothers, and difficulty
  # and cries variables are just the only observed values of either 0-11 or 12-23.

  child_difficulty <-
    reshape(data=data_subset,
            varying=list(
              Difficulty  = str_subset(names(data_subset), "Difficulty"),
              Cries_0_11  = str_subset(names(data_subset), "Cries_0_11"),
              Cries_12_23 = str_subset(names(data_subset), "Cries_12_23")),
              times=seq(1986,2000, by=2),
              ids=data_subset$child_id,
            direction="long") %>%
    arrange(mother_id, birth_year, birth_month) %>%
    mutate(Cries=case_when(
      !is.na(Cries_0_11_1986) ~ Cries_0_11_1986,
      !is.na(Cries_12_23_1986) ~ Cries_12_23_1986,
      TRUE ~ as.integer(NA)
    )) %>%
    select(-race, -m_prebirth_weight, -m_prepreg_weight, -weight_loss_gain,
           -Cries_0_11_1986, -Cries_12_23_1986, starts_with("prenatal")) %>%
    rename(Difficulty=Difficulty_1986) %>%
    filter(!is.na(Difficulty)) %>%
    group_by(child_id) %>%
    arrange(child_id, time) %>%
    slice(1L) %>%
    ungroup() %>%
    group_by(mother_id) %>%
    arrange(birth_year) %>%
    filter(n() > 1) %>%
    slice(1:2) %>%
    mutate(child_n=row_number()) %>%
    select(-birth_month, -birth_year, -time, -id, -child_id) %>%
    ungroup() %>%
    melt(id.vars=c("child_n", "mother_id")) %>%
    dcast(mother_id ~ ...) %>%
    mutate_at(vars(contains("Cries")), funs(as.ordered)) %>%
    mutate_at(vars(matches("(sex|prenatal_care|c_low_birth_weight)")), funs(factor))

  names(child_difficulty) <-
    ifelse(str_sub(names(child_difficulty),1,1) %in% c(1,2,3),
            paste0(str_sub(names(child_difficulty),3,-1),"_",
                   str_sub(names(child_difficulty),1,1) ),
           names(child_difficulty))

  return(child_difficulty)
}


standardize_child_difficulty <- function(child_difficulty){
  child_difficulty_std <- child_difficulty %>%
    mutate_at(vars(matches("(Difficulty|m_weight_change|c_birth_weight_oz)")),
              funs(standardize))
  return(child_difficulty_std)
}

save_child_difficulty <- function(){
  save(child_difficulty, file="./inst/data/derived_data/child_difficulty.RData")
  save(child_difficulty_std, file="./inst/data/derived_data/child_difficulty_std.RData")
}
