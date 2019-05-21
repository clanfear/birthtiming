load("./inst/data/derived_data/birthtiming_difficulty.RData")
load("./inst/data/derived_data/birthtiming_difficulty_std.RData")
library(lavaan)
library(dplyr)

# Get measures for later in life for all kids; can use as proxy if highly correlated with early life in existing sample

diff_model_naive <-
    '
    f1 =~ 1*difficulty_1 + 1*difficulty_2

    difficulty_1 ~ bage*m_age_at_birth_1
    difficulty_2 ~ bage*m_age_at_birth_2

    m_age_at_birth_1~~f1
    m_age_at_birth_2~~f1
    m_age_at_birth_1~~m_age_at_birth_2

    difficulty_1~~m_age_at_birth_2
    '

diff_model_naive_out <- lavaan::sem(model=diff_model_naive,
                                      data=birthtiming_difficulty %>%
                                        filter(!is.na(difficulty_1) & !is.na(difficulty_2)))
naive_tidy <- lavaan::parameterEstimates(diff_model_naive_out, standardized = T)

diff_model_naive_1st_only_out <- lavaan::sem(model=diff_model_naive,
                                    data=birthtiming_difficulty %>%
                                      filter(!is.na(difficulty_1) & !is.na(difficulty_2) & birth_order_1==1 & birth_order_2==2))
naive_1st_only_tidy <- lavaan::parameterEstimates(diff_model_naive_1st_only_out, standardized = T)


#--------

#

# Keepers:
# survey_age
# birth_order
# poverty
# sex

# Meh:
# smoking_binary
# drinking
# gestation_wks
# serious_health
# income
# childcare_binary_yr1
# birthweight_oz

diff_covariates_formula <-
  '
    f1 =~ 1*difficulty_1 + 1*difficulty_2

    difficulty_1 ~ bage*m_age_at_birth_1 + survey_age_1 + birth_order_1 + poverty_1 + sex_1
    difficulty_2 ~ bage*m_age_at_birth_2 + survey_age_2 + birth_order_2 + poverty_2 + sex_2
    difficulty_1~~m_age_at_birth_2

    f1 ~~ m_age_at_birth_1 + survey_age_1 + birth_order_1 + poverty_1  + sex_1
    f1 ~~ m_age_at_birth_2 + survey_age_2 + birth_order_2 + poverty_2  + sex_2

    m_age_at_birth_1 ~~ survey_age_1 + birth_order_1 + poverty_1 + m_age_at_birth_2 + survey_age_2 + birth_order_2 + poverty_2 + sex_1 + sex_2
    survey_age_1 ~~ birth_order_1 + poverty_1 + m_age_at_birth_2 + survey_age_2 + birth_order_2 + poverty_2 + sex_1 + sex_2
    birth_order_1 ~~ poverty_1 + m_age_at_birth_2 + survey_age_2 + birth_order_2 + poverty_2 + sex_1 + sex_2
    poverty_1 ~~ m_age_at_birth_2 + survey_age_2 + birth_order_2 + poverty_2 + sex_1 + sex_2
    m_age_at_birth_2 ~~ survey_age_2 + birth_order_2 + poverty_2 + sex_1 + sex_2
    survey_age_2 ~~ birth_order_2 + poverty_2 + sex_1 + sex_2
    birth_order_2 ~~ poverty_2 + sex_1 + sex_2
    poverty_2 ~~ sex_1 + sex_2
    sex_1 ~~ sex_2
   '

# age at survey, birth order, poverty, sex of child
# income, serious health, smoking, drinking, gestation length, birthweight

diff_covariates_out <- lavaan::sem(model=diff_covariates_formula,
                                    data=birthtiming_difficulty %>%
                                      filter(!is.na(difficulty_1) & !is.na(difficulty_2),
                                             !is.na(m_age_at_birth_1) & !is.na(m_age_at_birth_2)) %>%
                                     mutate_at(vars(income_1, income_2, birthweight_oz_1, birthweight_oz_2), ~scale(.)),
                                   orthogonal = FALSE, missing ="ML")
diff_covariates_tidy <- lavaan::parameterEstimates(diff_covariates_out, standardized = T)
diff_covariates_tidy

diff_covariates_1st_only_formula <-
  '
    f1 =~ 1*difficulty_1 + 1*difficulty_2

    difficulty_1 ~ bage*m_age_at_birth_1
    difficulty_2 ~ bage*m_age_at_birth_2
    difficulty_1~~m_age_at_birth_2

    f1 ~~ m_age_at_birth_1
    f1 ~~ m_age_at_birth_2

    m_age_at_birth_1 ~~ m_age_at_birth_2
   '

diff_covariates_1st_only_out <- lavaan::sem(model=diff_covariates_1st_only_formula,
                                   data=birthtiming_difficulty %>%
                                     filter(!is.na(difficulty_1)     &
                                            !is.na(difficulty_2)     &
                                            !is.na(m_age_at_birth_1) &
                                            !is.na(m_age_at_birth_2) &
                                            birth_order_1==1 &
                                            birth_order_2==2),
                                   missing ="ML")
diff_covariates_1st_only_tidy <- lavaan::parameterEstimates(diff_covariates_1st_only_out, standardized = T)
diff_covariates_1st_only_tidy

###

diff_covariates_group_formula <-
  '
    f1 =~ c(1,1)*difficulty_1 + c(1,1)*difficulty_2

    difficulty_1 ~ c(bage1,bage2)*m_age_at_birth_1 + survey_age_1 + birth_order_1 + sex_1
    difficulty_2 ~ c(bage1,bage2)*m_age_at_birth_2 + survey_age_2 + birth_order_2 + sex_2
    difficulty_1~~m_age_at_birth_2

    f1 ~~ m_age_at_birth_1 + survey_age_1 + birth_order_1 + sex_1
    f1 ~~ m_age_at_birth_2 + survey_age_2 + birth_order_2 + sex_2

    m_age_at_birth_1 ~~ survey_age_1 + birth_order_1 + m_age_at_birth_2 + survey_age_2 + birth_order_2 + sex_1 + sex_2
    survey_age_1 ~~ birth_order_1 + m_age_at_birth_2 + survey_age_2 + birth_order_2 + sex_1 + sex_2
    birth_order_1 ~~ m_age_at_birth_2 + survey_age_2 + birth_order_2 + sex_1 + sex_2
    m_age_at_birth_2 ~~ survey_age_2 + birth_order_2 + sex_1 + sex_2
    survey_age_2 ~~ birth_order_2 + sex_1 + sex_2
    birth_order_2 ~~ sex_1 + sex_2
    sex_1 ~~ sex_2
   '

# age at survey, birth order, poverty, sex of child
# income, serious health, smoking, drinking, gestation length,

diff_covariates_group_out <- lavaan::sem(model=diff_covariates_group_formula,
                                         data=birthtiming_difficulty %>%
                                           filter(!is.na(difficulty_1) & !is.na(difficulty_2) & !is.na(poverty_1)) %>%
                                           mutate(pov_group = case_when(
                                             is.na(poverty_1) ~ NA_character_,
                                             poverty_1 == 1 ~ "Poverty",
                                             poverty_1 == 0 ~ "No Poverty"
                                           )),
                                         group = "pov_group")
diff_covariates_group_tidy <- lavaan::parameterEstimates(diff_covariates_group_out, standardized = T)
diff_covariates_group_tidy

###

diff_naive_group <-
  '
    f1 =~ c(1,1)*difficulty_1 + c(1,1)*difficulty_2

    difficulty_1 ~ c(bage1,bage2)*m_age_at_birth_1
    difficulty_2 ~ c(bage1,bage2)*m_age_at_birth_2

    m_age_at_birth_1~~f1
    m_age_at_birth_2~~f1
    m_age_at_birth_1~~m_age_at_birth_2

    difficulty_1~~m_age_at_birth_2
    '
diff_naive_group_out <- lavaan::sem(model=diff_naive_group,
                                         data=birthtiming_difficulty %>%
                                           filter(!is.na(difficulty_1) & !is.na(difficulty_2) & !is.na(poverty_1)) %>%
                                      mutate(pov_group = case_when(
                                        is.na(poverty_1) ~ NA_character_,
                                        poverty_1 == 1 ~ "Poverty",
                                        poverty_1 == 0 ~ "No Poverty"
                                      )),
                                         group = "pov_group")
diff_naive_group_tidy <- lavaan::parameterEstimates(diff_naive_group_out, standardized = T)
diff_naive_group_tidy


###

diff_naive_3ch <-
  '
    f1 =~ 1*difficulty_1 + 1*difficulty_2 + 1*difficulty_3

    difficulty_1 ~ m_age_at_birth_1
    difficulty_2 ~ m_age_at_birth_2
    difficulty_3 ~ m_age_at_birth_3

    m_age_at_birth_1~~f1
    m_age_at_birth_2~~f1
    m_age_at_birth_3~~f1

    m_age_at_birth_1~~m_age_at_birth_2
    m_age_at_birth_2~~m_age_at_birth_3
    m_age_at_birth_1~~m_age_at_birth_3

    difficulty_1~~m_age_at_birth_2
    difficulty_2~~m_age_at_birth_3
    difficulty_1~~m_age_at_birth_3
    '


diff_naive_3ch_out <- lavaan::sem(model=diff_naive_3ch,
                                    data=birthtiming_difficulty %>%
                                      filter(!is.na(difficulty_1) & !is.na(difficulty_2) &
                                               !is.na(difficulty_3)))
diff_naive_3ch_tidy <- lavaan::parameterEstimates(diff_naive_3ch_out, standardized = T)
diff_naive_3ch_tidy
