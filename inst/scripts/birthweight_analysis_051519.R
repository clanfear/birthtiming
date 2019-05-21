birthweight_naive_model <-
  '
    f1 =~ 1*birthweight_oz_1 + 1*birthweight_oz_2

    birthweight_oz_1 ~ bage*m_age_at_birth_1
    birthweight_oz_2 ~ bage*m_age_at_birth_2

    m_age_at_birth_1~~f1
    m_age_at_birth_2~~f1
    m_age_at_birth_1~~m_age_at_birth_2

    birthweight_oz_1~~m_age_at_birth_2
  '

birthweight_naive_out <- lavaan::sem(model=birthweight_naive_model,
                                     data=birthtiming_difficulty_std %>%
                                       filter(!is.na(birthweight_oz_1) & !is.na(birthweight_oz_2)), missing = "ML")
birthweight_naive_tidy <- lavaan::parameterEstimates(birthweight_naive_out, standardized = T)
