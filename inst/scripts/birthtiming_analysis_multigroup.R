####
# Things to do"

# 1) Take 3 sibling model, run with full data then split off half and fill in missings and compare
# 2) Simpler model: Basically a mimic

## Set cov=0 for instrument, check changes in params
## Drop cov(age, shared) and look at changes (this is RE)
## Consider disabled children

library(lavaan)
library(semPlot)
library(lavaanPlot)
library(dplyr)

load("./inst/data/derived_data/birthtiming_difficulty.RData")
load("./inst/data/derived_data/birthtiming_difficulty_std.RData")

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

summary(lavaan::sem(model=diff_model_naive, data=birthtiming_difficulty), standardized=T)

#---------------------
# 3rd child model, FIML
diff_model_3child_formula <-
    '
    f1 =~ 1*difficulty_1 + 1*difficulty_2 + 1*difficulty_3

    difficulty_1 ~ bage*m_age_at_birth_1
    difficulty_2 ~ bage*m_age_at_birth_2
    difficulty_3 ~ bage*m_age_at_birth_3

    m_age_at_birth_1~~f1
    m_age_at_birth_2~~f1
    m_age_at_birth_3~~f1

    m_age_at_birth_1~~m_age_at_birth_2
    m_age_at_birth_1~~m_age_at_birth_3
    m_age_at_birth_2~~m_age_at_birth_3

    difficulty_1~~m_age_at_birth_2
    difficulty_2~~m_age_at_birth_3
    '

diff_model_3child_ml <- lavaan::sem(model=diff_model_3child_formula, data=birthtiming_difficulty %>% filter(!is.na(difficulty_3)))
summary(diff_model_3child_ml)

diff_model_3child_ml_miss <- lavaan::sem(model=diff_model_3child_formula,
                                    data=birthtiming_difficulty %>%
                                      filter(!is.na(difficulty_3)) %>%
                                      mutate(draw=round(runif(nrow(.),0,1)*.7,0)) %>%
                                      mutate(difficulty_3 = ifelse(draw==1, NA, difficulty_3),
                                             m_age_at_birth_3 = ifelse(draw==1, NA, m_age_at_birth_3))
                                    , missing="ML")
summary(diff_model_3child_ml_miss)


lavaan::parameterEstimates(diff_model_3child, standardized = T)

lavaanPlot(name="Naive", model=diff_model_3child, coefs=TRUE, covs=TRUE, node_options = list(shape = "box", fontname = "Helvetica"), edge_options = list(color = "grey"))
semPaths(diff_model_3child_ml)


#-----------------
diff_model_3child_ml <- lavaan::sem(model=diff_model_3child_formula, data=birthtiming_difficulty, missing="FIML")
summary(diff_model_3child_ml)
#diff_model_3child_lwd <- lavaan::sem(model=diff_model_3child_formula, data=birthtiming_difficulty)

#--------------------------
# 3 child with covariates
diff_model_3child_full_formula <-
'
f1 =~ 1*difficulty_1 + 1*difficulty_2 + 1*difficulty_3

difficulty_1 ~ bage*m_age_at_birth_1 + survey_age_1 + birth_order_1 + childcare_binary_yr1_1 + drinking_1 + highest_grade_1 + multibirth_1 + poverty_1 + serious_health_1 + sex_1 + smoking_binary_1
difficulty_2 ~ bage*m_age_at_birth_2 + survey_age_2 + birth_order_2 + childcare_binary_yr1_2 + drinking_2 + highest_grade_2 + multibirth_2 + poverty_2 + serious_health_2 + sex_2 + smoking_binary_2
difficulty_3 ~ bage*m_age_at_birth_3 + survey_age_3 + birth_order_3 + childcare_binary_yr1_3 + drinking_3 + highest_grade_3 + multibirth_3 + poverty_3 + serious_health_3 + sex_3 + smoking_binary_3

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

m_age_at_birth_3 ~~ f1 +  survey_age_3 + birth_order_3 + childcare_binary_yr1_3 + drinking_3 + highest_grade_3 + multibirth_3 + poverty_3 + serious_health_3 + sex_3 + smoking_binary_3
f1 ~~  survey_age_3 + birth_order_3 + childcare_binary_yr1_3 + drinking_3 + highest_grade_3 + multibirth_3 + poverty_3 + serious_health_3 + sex_3 + smoking_binary_3
survey_age_3 ~~ birth_order_3 + childcare_binary_yr1_3 + drinking_3 + highest_grade_3 + multibirth_3 + poverty_3 + serious_health_3 + sex_3 + smoking_binary_3
birth_order_3 ~~  childcare_binary_yr1_3 + drinking_3 + highest_grade_3 + multibirth_3 + poverty_3 + serious_health_3 + sex_3 + smoking_binary_3
childcare_binary_yr1_3 ~~ drinking_3 + highest_grade_3 + multibirth_3 + poverty_3 + serious_health_3 + sex_3 + smoking_binary_3
drinking_3 ~~ highest_grade_3 + multibirth_3 + poverty_3 + serious_health_3 + sex_3 + smoking_binary_3
highest_grade_3 ~~ multibirth_3 + poverty_3 + serious_health_3 + sex_3 + smoking_binary_3
multibirth_3 ~~ poverty_3 + serious_health_3 + sex_3 + smoking_binary_3
poverty_3 ~~ serious_health_3 + sex_3 + smoking_binary_3
serious_health_3 ~~ sex_3 + smoking_binary_3
sex_3 ~~ smoking_binary_3

m_age_at_birth_1 ~~ m_age_at_birth_2 + m_age_at_birth_3
m_age_at_birth_2 ~~ m_age_at_birth_3

birth_order_1 ~~  birth_order_2 + birth_order_3
birth_order_2 ~~ birth_order_3

childcare_binary_yr1_1 ~~ childcare_binary_yr1_2 + childcare_binary_yr1_3
childcare_binary_yr1_2 ~~ childcare_binary_yr1_3

drinking_1 ~~ drinking_2 + drinking_3
drinking_2 ~~ drinking_3

highest_grade_1 ~~ highest_grade_2 + highest_grade_3
highest_grade_2 ~~ highest_grade_3

multibirth_1 ~~ multibirth_2 + multibirth_3
multibirth_2 ~~ multibirth_3

poverty_1 ~~ poverty_2 + poverty_3
poverty_2 ~~ poverty_3

serious_health_1 ~~ serious_health_2 + serious_health_3
serious_health_2 ~~ serious_health_3

sex_1 ~~ sex_2 + sex_3
sex_2 ~~ sex_3

smoking_binary_1 ~~ smoking_binary_2 + smoking_binary_3
smoking_binary_2 ~~ smoking_binary_3

survey_age_1 ~~ survey_age_2 + survey_age_3
survey_age_2 ~~ survey_age_3

difficulty_1~~m_age_at_birth_2
difficulty_2~~m_age_at_birth_3
difficulty_1~~m_age_at_birth_3
'
diff_model_3child_full_ml <- lavaan::sem(model=diff_model_3child_full_formula, data=birthtiming_difficulty_std, missing="ML")
parameterEstimates(diff_model_3child_full_ml) %>% filter( (lhs=="difficulty_1"     & op=="~~" & rhs=="m_age_at_birth_2") |
                                                          (lhs=="difficulty_2"     & op=="~~" & rhs=="m_age_at_birth_3") |
                                                          (lhs=="difficulty_1"     & op=="~~" & rhs=="m_age_at_birth_3") |
                                                          (rhs=="m_age_at_birth_1" & op=="~"  & lhs=="difficulty_1") |
                                                          (rhs=="m_age_at_birth_2" & op=="~"  & lhs=="difficulty_2") |
                                                          (rhs=="m_age_at_birth_3" & op=="~"  & lhs=="difficulty_3")) %>%
  mutate_if(is.numeric, round, digits=3)
