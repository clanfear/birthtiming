
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

diff_model_naive_out <- lavaan::sem(model=diff_model_naive, data=birthtiming_difficulty)
naive_tidy <- lavaan::parameterEstimates(diff_model_naive_out, standardized = T)
lavaanPlot(name="Naive", model=diff_model_full_out, coefs=TRUE, covs=TRUE, sig=1.00)
