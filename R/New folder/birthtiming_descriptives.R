library(dplyr)
library(corrplot)
library(stringr)
library(tibble)
library(tidyr)
load("./inst/data/derived_data/birthtiming_difficulty.RData")
load("./inst/data/derived_data/birthtiming_difficulty_std.RData")

#-----

corr_3child <- birthtiming_difficulty %>%
  filter(!is.na(birth_order_3)) %>%
  select(ends_with("1"), ends_with("2")) %>%
  mutate_all(as.numeric) %>%
  cor(use="pairwise.complete.obs")

corr_2child <- birthtiming_difficulty %>%
  filter(is.na(birth_order_3)) %>%
  select(ends_with("1"), ends_with("2")) %>%
  mutate_all(as.numeric) %>%
  cor(use="pairwise.complete.obs")

corrplot(corr_3child - corr_2child, type="lower")

data.frame(corr=(birthtiming_difficulty %>%
  mutate(n_children = ifelse(!is.na(birth_order_3), 3, 2)) %>%
  select(n_children, ends_with("1"), ends_with("2")) %>%
  mutate_all(as.numeric) %>%
  cor(use="pairwise.complete.obs"))[,1]) %>%
  rownames_to_column() %>%
  filter(rowname != "n_children") %>%
  mutate(birth_n = str_extract(rowname, ".$"),
         rowname = str_replace(rowname, "_.$", "")) %>%
  spread(birth_n, corr)

# Women in the 3 child sample are...
## More likely to be substantially younger at first and second birth
## More likely to be in poverty at first and second birth
## Less likely to use childcare at first and second birth
## Report slightly higher difficulty at first and second birth
## Slightly more likely to spank
