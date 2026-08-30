#generate fake banding data
library(tidyverse)
library(lubridate)
library(hms)

banding_data <- tibble(
  net_id = "A",
  species_code = "INBU",
  time = as_hms(Sys.time()),
  bander = "Christine Best",
  code = "R",
  band_number = "301025134",
  hp_age = "ASY",
  wrp_age = NA_character_,
  molt_location_1 = "GC 1-6",
  molt_location_2 = "CC",
  molt_location_3 = NA_character_,
  molt_location_4 = NA_character_,
  sex = "M",
  skull = NA_character_,
  bp = 0,
  cp = 1,
  fat = 2,
  b_molt = 0,
  ff_molt = 0,
  molt_score = NA_integer_,
  wing_chord = 66.0,
  tarsus = 17,
  weight = 11.3,
  status = 300,
  recapture_year = year(Sys.Date()),
  recapture_month = month(Sys.Date(), label = TRUE, abbr = FALSE),
  recapture_day = mday(Sys.Date()),
  recapture_time = as_hms(Sys.time() - days(30)),
  recapture_net = "A",
  recapture_location = "Hays Woods",
  notes = "Fake data for testing purposes"
)
