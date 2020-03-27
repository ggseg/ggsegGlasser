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

devtools::load_all("../../ggsegExtra/")
glasser_3d <- ggsegExtra:::restruct_old_3datlas(glasser_3d)
glasser_3d <- as_ggseg3d_atlas(glasser_3d)
usethis::use_data(glasser_3d, internal = FALSE, overwrite = TRUE)
