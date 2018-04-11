library(lavaan)
library(semPlot)
load("./inst/data/derived_data/child_difficulty.RData")
load("./inst/data/derived_data/child_difficulty_std.RData")
#-----------------------------------------------------------------------------------
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

diff_model_naive_out <- sem(model=diff_model_naive, data=child_difficulty)
naive_tidy <- parameterEstimates(diff_model_naive_out, standardized = T)
save(naive_tidy, file="./inst/data/derived_data/naive_tidy.RData")

# summary(diff_model_naive_out)
# semPaths(diff_model_naive_out, whatLabels = "std")



diff_model_full <-
  '
f1 =~ 1*Difficulty_1 + 1*Difficulty_2

Difficulty_1 ~ bage*m_age_at_birth_1 + c_birth_weight_oz_1 + sex_1 + gestation_time_1
Difficulty_2 ~ bage*m_age_at_birth_2 + c_birth_weight_oz_2 + sex_2 + gestation_time_2

m_age_at_birth_1~~f1 + c_birth_weight_oz_1 + sex_1 + gestation_time_1
m_age_at_birth_2~~f1 + c_birth_weight_oz_2 + sex_2 + gestation_time_2
m_age_at_birth_1~~m_age_at_birth_2


Difficulty_1~~m_age_at_birth_2
'

diff_model_out <- sem(model=diff_model_full, data=child_difficulty_std, missing = "ML")
# summary(diff_model_out)
# semPaths(diff_model_out, what="std")
