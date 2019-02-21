# PICK UP HERE
# Things to fix: 0 times to next birth
library(lubridate)
library(survival)

child_censoring <- long_data %>%
  group_by(child_id) %>%
  mutate(Difficulty= ifelse(
    all(is.na(Difficulty)),
    NA,
    max(Difficulty, na.rm = T))
  ) %>%
  mutate(health_issue=case_when(
    any(treatment %in% 1 | medicine %in% 1 | equipment %in% 1) ~ as.numeric(1),
    any(treatment %in% 0 | medicine %in% 0 | equipment %in% 0) ~ as.numeric(0),
    TRUE ~ as.numeric(NA))) %>%
  ungroup() %>%
  distinct(child_id, .keep_all = T) %>%
  group_by(mother_id, child_dob) %>%
  arrange(child_dob) %>%
  mutate(multibirth=ifelse(n() > 1, n(), 0),
         time_to_next_birth=ifelse(all(is.na(time_to_next_birth)), NA, max(time_to_next_birth, na.rm=T)),
         Difficulty=mean(Difficulty, na.rm=T),
         sex=mean(sex),
         health_issue=max(health_issue),
         Parity=max(Parity)) %>%
  slice(1L) %>%
  mutate(followed_by_birth=ifelse(time_to_next_birth==Inf, 0, 1)) %>%
  filter(!is.na(Difficulty)) %>%
  ungroup()

child_censoring_surv <- Surv(time=child_censoring$time_to_next_birth, event=child_censoring$followed_by_birth)
