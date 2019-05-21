load("./inst/data/derived_data/birthtiming_difficulty.RData")
load("./inst/data/derived_data/birthtiming_difficulty_std.RData")

library(ggplot2)
library(ggplot2)

birthtiming_difficulty %>%
  filter(!is.na(difficulty_1) & !is.na(difficulty_2) & !is.na(poverty_1) & birth_order_1==1) %>%
  ggplot(aes(x=m_age_at_birth_1, y=difficulty_1)) + facet_grid(~poverty_1) +
  stat_density_2d(aes(fill = stat(level)), geom = "polygon") + geom_smooth(method="lm")
