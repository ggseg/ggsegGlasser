devtools::load_all("../../ggsegExtra/")
devtools::load_all(".")



# Make  3d ----
# read_annotation("data-raw/lh.HCPMMP1.annot")
# make_aparc_2_3datlas("HCPMMP1", )


# Make palette ----
brain_pals <- make_palette_ggseg(glasser_3d)

usethis::use_data(brain_pals, internal = TRUE, overwrite = TRUE)
devtools::load_all(".")

# make atlas ----

glasser <- ggsegExtra::make_ggseg3d_2_ggseg(glasser_3d,
                                            steps = 3:7,
                                            smoothness = 2,
                                            tolerance = .5,
                                            output_dir = "data-raw/")

# remove name from medial wall
glasser <- glasser %>%
  mutate(region = ifelse(grepl("wall", region), NA, region)) %>%
  as_ggseg_atlas()

# glasser$geometry <- NULL
# glasser <- as_tibble(glasser)
# glasser <- as_ggseg_atlas(glasser)
ggseg(atlas=glasser, show.legend = FALSE,
      # colour = "black",
      position="stacked",
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
