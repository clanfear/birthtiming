library(lavaan)

complete_cov <- getCov(
  "
  180.90
  126.77 217.56
  23.96 30.20 16.24
  22.86 30.47 14.36 15.13
  ", names=c("f_occ_y1", "f_occ_y2", "f_ed_y1", "f_ed_y2")
)

getCov(complete_cov)
complete_mean <- c(16.62, 17.39, 6.65, 6.75)
complete_n <- 348

incomplete_cov <- getCov(
  "
  217.27
  0.0 1.0
  25.57 0.0 16.16
  0.0 0.0 0.0 1.0
  ", names=c("f_occ_y1", "f_occ_y2", "f_ed_y1", "f_ed_y2")
  )
incomplete_mean <- c(16.98, 0.0, 6.83, 0.0)
incomplete_n <- 1672

allison_cfa <- "
  nu_1 =~ 1*f_occ_y1 + f_occ_y2
  nu_2 =~ 1*f_ed_y1 + f_ed_y2
  nu_1 ~~ nu_2
"


summary(sem(allison_cfa, sample.cov=complete_cov, sample.nobs=complete_n, sample.mean = complete_mean))

allison_cfa_group <- "
  nu_1 =~ c(1,1)*f_occ_y1 + c(l21,0)*f_occ_y2
  nu_2 =~ c(1,1)*f_ed_y1 + c(l42,0)*f_ed_y2
  nu_1 ~~ c(n1,n1)*nu_1
  nu_2 ~~ c(n2,n2)*nu_2
  nu_1 ~~ c(nn,nn)*nu_2
  f_occ_y2 ~~ c(v1,0)*f_occ_y2
  f_ed_y2 ~~ c(v2,0)*f_ed_y2
  f_occ_y1 ~~ c(y1,y1)*f_occ_y1
  f_ed_y1 ~~ c(y2,y2)*f_ed_y1
"

summary(sem(allison_cfa_group, sample.cov=list(complete_cov, incomplete_cov),
            sample.nobs=list(complete_n, incomplete_n),
            sample.mean = list(complete_mean, incomplete_mean), meanstructure=T))
