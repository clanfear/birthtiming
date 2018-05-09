####
# Things to do"
## Set cov=0 for instrument, check changes in params
## Drop cov(age, shared) and look at changes (this is RE)
## Consider disabled children

run_naive_sem <- function(){
  diff_model_naive <-
    '
    f1 =~ 1*Difficulty_1 + 1*Difficulty_2

    Difficulty_1 ~ bage*m_age_at_birth_1
    Difficulty_2 ~ bage*m_age_at_birth_2

    m_age_at_birth_1~~f1
    m_age_at_birth_2~~f1
    m_age_at_birth_1~~m_age_at_birth_2

    Difficulty_1~~m_age_at_birth_2
    '

  diff_model_naive_out <- lavaan::sem(model=diff_model_naive, data=child_difficulty)
  naive_tidy <- lavaan::parameterEstimates(diff_model_naive_out, standardized = T)
  return(naive_tidy)
}

run_full_sem <- function(){
  diff_model_full <-
    '
  f1 =~ 1*Difficulty_1 + 1*Difficulty_2

  Difficulty_1 ~ bage*m_age_at_birth_1 + c_birth_weight_oz_1 + sex_1 + gestation_time_1 + treatment_1 + medicine_1 + equipment_1
  Difficulty_2 ~ bage*m_age_at_birth_2 + c_birth_weight_oz_2 + sex_2 + gestation_time_2+ treatment_2 + medicine_2 + equipment_2

  m_age_at_birth_1~~f1 + c_birth_weight_oz_1 + sex_1 + gestation_time_1 + treatment_1 + medicine_1 + equipment_1
  m_age_at_birth_2~~f1 + c_birth_weight_oz_2 + sex_2 + gestation_time_2 + treatment_2 + medicine_2 + equipment_2
  m_age_at_birth_1~~m_age_at_birth_2


  Difficulty_1~~m_age_at_birth_2
  '

  diff_model_full_out <- lavaan::sem(model=diff_model_full, data=child_difficulty_std, missing = "ML")
  full_tidy <- lavaan::parameterEstimates(diff_model_full_out, standardized = T)
  return(full_tidy)
}
