####
# Things to do"
## Set cov=0 for instrument, check changes in params
## Drop cov(age, shared) and look at changes (this is RE)
## Consider disabled children

library(dplyr)
library(stringr)
library(tidyr)
library(reshape2)
library(lavaan)
library(lavaanPlot)

source("./inst/scripts/birthtiming_data_processing_functional.R")

# Edit gen function so birthtiming 1:2 doesn't get only birth order 2 children for missing 1s.

birthtiming_difficulty_12 <- gen_birthtiming_data(min_children=2, max_children=10) %>%
  filter(!is.na(difficulty_1) & !is.na(difficulty_2))

birthtiming_difficulty_12_m <- gen_birthtiming_data(min_children=2, max_children=10)

birthtiming_difficulty_23 <- gen_birthtiming_data(min_children=2, max_children=10) %>%
  filter(!is.na(difficulty_2) & !is.na(difficulty_3)) %>%
  mutate(difficulty_1 = difficulty_2, difficulty_2=difficulty_3)

# load("./inst/data/derived_data/birthtiming_difficulty.RData")
# load("./inst/data/derived_data/birthtiming_difficulty_std.RData")

diff_model_2ch <-
    '
    f1 =~ 1*difficulty_1 + 1*difficulty_2

    difficulty_1 ~ bage*m_age_at_birth_1
    difficulty_2 ~ bage*m_age_at_birth_2

    m_age_at_birth_1~~f1
    m_age_at_birth_2~~f1
    m_age_at_birth_1~~m_age_at_birth_2

    difficulty_1~~m_age_at_birth_2
    '

diff_model_2ch_12_out <- lavaan::sem(model=diff_model_2ch, data=birthtiming_difficulty_12)
diff_model_2ch_12_out_tidy <- lavaan::parameterEstimates(diff_model_2ch_12_out, standardized = T)
summary(diff_model_2ch_12_out)

diff_model_2ch_23_out <- lavaan::sem(model=diff_model_2ch, data=birthtiming_difficulty_23)
diff_model_2ch_23_out_tidy <- lavaan::parameterEstimates(diff_model_2ch_23_out, standardized = T)
summary(diff_model_2ch_23_out)

diff_model_2ch_12_m_out <- lavaan::sem(model=diff_model_2ch, data=birthtiming_difficulty_12_m, missing = "ML")
diff_model_2ch_12_m_out_tidy <- lavaan::parameterEstimates(diff_model_2ch_12_m_out, standardized = T)
summary(diff_model_2ch_12_m_out)

rbind(
  cbind(model="Model_12", diff_model_2ch_12_out_tidy)[c(3,4,8), ],
  cbind(model="Model_12_m", diff_model_2ch_12_m_out_tidy)[c(3,4,8), ],
  cbind(model="Model_23", diff_model_2ch_23_out_tidy)[c(3,4,8), ]
)[, c(1,2,3,4,6,7,9)]

diff_model_2ch_noinst <-
  '
f1 =~ 1*difficulty_1 + 1*difficulty_2

difficulty_1 ~ bage*m_age_at_birth_1
difficulty_2 ~ bage*m_age_at_birth_2

m_age_at_birth_1~~f1
m_age_at_birth_2~~f1
m_age_at_birth_1~~m_age_at_birth_2
'

diff_model_2ch_12_noinst_out <- lavaan::sem(model=diff_model_2ch_noinst, data=birthtiming_difficulty_12)
diff_model_2ch_12_noinst_out_tidy <- lavaan::parameterEstimates(diff_model_2ch_12_noinst_out, standardized = T)
summary(diff_model_2ch_12_noinst_out)
#-------------------------

diff_model_2ch <-
  '
    f1 =~ 1*difficulty_1 + 1*difficulty_2

    difficulty_1 ~ bage*m_age_at_birth_1
    difficulty_2 ~ bage*m_age_at_birth_2

    m_age_at_birth_1~~f1
    m_age_at_birth_2~~f1
    m_age_at_birth_1~~m_age_at_birth_2

    difficulty_1~~m_age_at_birth_2
    '

diff_model_2ch_12_out <- lavaan::sem(model=diff_model_2ch, data=birthtiming_difficulty_12)
diff_model_2ch_12_out_tidy <- lavaan::parameterEstimates(diff_model_2ch_out, standardized = T)
summary(diff_model_2ch_12_out)

#-------------------------

diff_model_3ch <-
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

gen_birthtiming_data(min_children=2, max_children=10) %>%
  filter(!is.na(difficulty_1) & !is.na(difficulty_2) & !is.na(difficulty_3)) %>%
  lavaan::sem(model=diff_model_3ch, data=.) %>% summary()

#---------------------
# LOW/HIGH INC SUBSAMPLES
birthtiming_difficulty_poverty <- birthtiming_difficulty %>% filter(poverty_1==1)
birthtiming_difficulty_no_poverty <- birthtiming_difficulty %>% filter(poverty_1==0)

diff_model_pov_out <- lavaan::sem(model=diff_model_naive, data=birthtiming_difficulty_poverty)
# Mother's age -> difficulty coefficient is incredibly small, large SE, no feedback effect

diff_model_no_pov_out <- lavaan::sem(model=diff_model_naive, data=birthtiming_difficulty_no_poverty)
# Mother's age -> difficulty coefficient is larger, small SE, feedback effect grows


diff_model_interaction <-
  '
f1 =~ 1*difficulty_1 + 1*difficulty_2

difficulty_1 ~ bage*m_age_at_birth_1 + poverty_1 + pov_mage_1
difficulty_2 ~ bage*m_age_at_birth_2 + poverty_2 + pov_mage_2

m_age_at_birth_1~~f1 + poverty_1 + pov_mage_1
f1 ~~ poverty_1 + pov_mage_1
poverty_1 ~~ pov_mage_1

m_age_at_birth_2~~f1 + poverty_2 + pov_mage_2
f1 ~~ poverty_2 + pov_mage_2
poverty_2 ~~ pov_mage_2

poverty_1 ~~ poverty_2
pov_mage_1 ~~ pov_mage_2

m_age_at_birth_1~~m_age_at_birth_2

difficulty_1~~m_age_at_birth_2
'

diff_model_int <- lavaan::sem(model=diff_model_interaction,
  data = birthtiming_difficulty_std %>%
  mutate(pov_mage_1 = poverty_1*m_age_at_birth_1,
         pov_mage_2 = poverty_2*m_age_at_birth_2))

library(ggeffects)
lm(difficulty_1 ~ m_age_at_birth_1*poverty_1, data=birthtiming_difficulty) %>%
  ggpredict(terms=c("m_age_at_birth_1", "poverty_1")) %>% plot()

lm(difficulty_2 ~ m_age_at_birth_2*poverty_2, data=birthtiming_difficulty) %>%
  ggpredict(terms=c("m_age_at_birth_2", "poverty_2")) %>% plot()

#--------------------
diff_model_full <-
    '
    f1 =~ 1*difficulty_1 + 1*difficulty_2

    difficulty_1 ~ bage*m_age_at_birth_1 + survey_age_1 + birth_order_1 + childcare_binary_yr1_1 + drinking_1 + highest_grade_1 + multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    difficulty_2 ~ bage*m_age_at_birth_2 + survey_age_2 + birth_order_2 + childcare_binary_yr1_2 + drinking_2 + highest_grade_2 + multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2

    m_age_at_birth_1 ~~ f1 +  survey_age_1 + birth_order_1 + childcare_binary_yr1_1 + drinking_1 + highest_grade_1 + multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    f1 ~~ survey_age_1 + birth_order_1 + childcare_binary_yr1_1 + drinking_1 + highest_grade_1 + multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    survey_age_1 ~~ birth_order_1 + childcare_binary_yr1_1 + drinking_1 + highest_grade_1 + multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    birth_order_1 ~~  childcare_binary_yr1_1 + drinking_1 + highest_grade_1 + multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    childcare_binary_yr1_1 ~~ drinking_1 + highest_grade_1 + multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    drinking_1 ~~ highest_grade_1 + multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    highest_grade_1 ~~ multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    multibirth_1 ~~ poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    poverty_1 ~~ serious_health_1 + sex_1 + smoking_binary_1
    serious_health_1 ~~ sex_1 + smoking_binary_1
    sex_1 ~~ smoking_binary_1

    m_age_at_birth_2 ~~ f1 +  survey_age_2 + birth_order_2 + childcare_binary_yr1_2 + drinking_2 + highest_grade_2 + multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
    f1 ~~  survey_age_2 + birth_order_2 + childcare_binary_yr1_2 + drinking_2 + highest_grade_2 + multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
    survey_age_2 ~~ birth_order_2 + childcare_binary_yr1_2 + drinking_2 + highest_grade_2 + multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
    birth_order_2 ~~  childcare_binary_yr1_2 + drinking_2 + highest_grade_2 + multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
    childcare_binary_yr1_2 ~~ drinking_2 + highest_grade_2 + multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
    drinking_2 ~~ highest_grade_2 + multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
    highest_grade_2 ~~ multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
    multibirth_2 ~~ poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
    poverty_2 ~~ serious_health_2 + sex_2 + smoking_binary_2
    serious_health_2 ~~ sex_2 + smoking_binary_2
    sex_2 ~~ smoking_binary_2

    m_age_at_birth_1 ~~ m_age_at_birth_2
    birth_order_1 ~~  birth_order_2
    childcare_binary_yr1_1 ~~ childcare_binary_yr1_2
    drinking_1 ~~ drinking_2
    highest_grade_1 ~~ highest_grade_2
    multibirth_1 ~~ multibirth_2
    poverty_1 ~~ poverty_2
    serious_health_1 ~~ serious_health_2
    sex_1 ~~ sex_2
    smoking_binary_1 ~~ smoking_binary_2
    survey_age_1 ~~ survey_age_2

    difficulty_1~~m_age_at_birth_2
  '

diff_model_full_out <- lavaan::sem(model=diff_model_full, data=birthtiming_difficulty_std, missing = "ML")
full_tidy <- lavaan::parameterEstimates(diff_model_full_out, standardized = T)


diff_bw_model_full <-
  '
    f1 =~ 1*difficulty_1 + 1*difficulty_2 + 1*birthweight_oz_1 + 1*birthweight_oz_2

    difficulty_1 ~ bage*m_age_at_birth_1 + birthweight_oz_1 + birth_order_1 + childcare_binary_yr1_1 + drinking_1 + highest_grade_1 + multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    difficulty_2 ~ bage*m_age_at_birth_2 + birthweight_oz_2 + birth_order_2 + childcare_binary_yr1_2 + drinking_2 + highest_grade_2 + multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2

    birthweight_oz_1 ~ bage2*m_age_at_birth_1 + birth_order_1 + drinking_1 + highest_grade_1 + multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    birthweight_oz_2 ~ bage2*m_age_at_birth_2 + birth_order_2 + drinking_2 + highest_grade_2 + multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2


    m_age_at_birth_1 ~~ f1 +  birth_order_1 + childcare_binary_yr1_1 + drinking_1 + highest_grade_1 + multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    f1 ~~  birth_order_1 + childcare_binary_yr1_1 + drinking_1 + highest_grade_1 + multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    birth_order_1 ~~  childcare_binary_yr1_1 + drinking_1 + highest_grade_1 + multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    childcare_binary_yr1_1 ~~ drinking_1 + highest_grade_1 + multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    drinking_1 ~~ highest_grade_1 + multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    highest_grade_1 ~~ multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    multibirth_1 ~~ poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
    poverty_1 ~~ serious_health_1 + sex_1 + smoking_binary_1
    serious_health_1 ~~ sex_1 + smoking_binary_1
    sex_1 ~~ smoking_binary_1

    m_age_at_birth_2 ~~ f1 +  birth_order_2 + childcare_binary_yr1_2 + drinking_2 + highest_grade_2 + multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
    f1 ~~  birth_order_2 + childcare_binary_yr1_2 + drinking_2 + highest_grade_2 + multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
    birth_order_2 ~~  childcare_binary_yr1_2 + drinking_2 + highest_grade_2 + multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
    childcare_binary_yr1_2 ~~ drinking_2 + highest_grade_2 + multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
    drinking_2 ~~ highest_grade_2 + multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
    highest_grade_2 ~~ multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
    multibirth_2 ~~ poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
    poverty_2 ~~ serious_health_2 + sex_2 + smoking_binary_2
    serious_health_2 ~~ sex_2 + smoking_binary_2
    sex_2 ~~ smoking_binary_2

    m_age_at_birth_1 ~~ m_age_at_birth_2
    birth_order_1 ~~  birth_order_2
    childcare_binary_yr1_1 ~~ childcare_binary_yr1_2
    drinking_1 ~~ drinking_2
    highest_grade_1 ~~ highest_grade_2
    multibirth_1 ~~ multibirth_2
    poverty_1 ~~ poverty_2
    serious_health_1 ~~ serious_health_2
    sex_1 ~~ sex_2
    smoking_binary_1 ~~ smoking_binary_2

    difficulty_1~~m_age_at_birth_2
    birthweight_oz_1~~m_age_at_birth_2
  '

diff_bw_model_full_out <- lavaan::sem(model=diff_bw_model_full, data=birthtiming_difficulty_std, missing = "ML")
# full_tidy <- lavaan::parameterEstimates(diff_model_full_out, standardized = T)

lavaanPlot(name="Full", diff_bw_model_full_out, coefs=T)
