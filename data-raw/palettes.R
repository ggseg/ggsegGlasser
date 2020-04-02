devtools::load_all("../../ggsegExtra/")
devtools::load_all(".")

# Make palette ----
brain_pals <- make_palette_ggseg(glasser_3d)

usethis::use_data(brain_pals, internal = TRUE, overwrite = TRUE)
devtools::load_all(".")

# make atlas ----

glasser <- ggsegExtra::make_ggseg3d_2_ggseg(glasser_3d,
                                               steps = 1:7,
                                               smoothness = 8,
                                               keep = 0.05,
                                               output_dir = "~/Desktop/test/")

# remove name from medial wall
glasser <- glasser %>%
  mutate(region = ifelse(grepl("wall", region), NA, region))

ggseg(atlas=glasser, show.legend = FALSE,
      colour = "black", position="stacked",
      alpha=.6,
      mapping = aes(fill=region)) +
  scale_fill_brain("glasser", package = "ggsegGlasser")


usethis::use_data(glasser,
                  internal = FALSE,
                  overwrite = TRUE,
                  compress="xz")


# Make palette
# k <- dplyr::slice(glasser_3d, 1) %>%
#   unnest(ggseg_3d) %>%
#   select(region, colour) %>%
#   filter(!grepl("wall", region))
#
# brain_pals = list(
#   glasser = setNames(k$colour, k$region)
# )
# usethis::use_data(brain_pals, internal = TRUE, overwrite = TRUE)
#
# devtools::load_all("../../ggsegExtra/")
# glasser_3d <- ggsegExtra:::restruct_old_3datlas(glasser_3d)
# glasser_3d <- as_ggseg3d_atlas(glasser_3d)
# usethis::use_data(glasser_3d, internal = FALSE, overwrite = TRUE)
