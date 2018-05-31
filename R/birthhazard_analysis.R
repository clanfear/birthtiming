summary(glm(followed_by_birth~Difficulty + Parity + m_age_at_birth + multibirth, family=binomial(link="logit"), data=child_censoring))
# coxph(child_censoring_surv~Difficulty + Parity + m_age_at_birth + multibirth, data=child_censoring)

# survfit(child_censoring_surv~1)
