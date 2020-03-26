library(dplyr)

# Make palette
k <- dplyr::slice(glasser_3d, 1) %>%
  unnest(ggseg_3d) %>%
  select(region, colour) %>%
  filter(!grepl("wall", region))

brain_pals = list(
  glasser = setNames(k$colour, k$region)
)
usethis::use_data(brain_pals, internal = TRUE, overwrite = TRUE)

