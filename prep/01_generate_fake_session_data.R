#generate fake session data
library(tidyverse)
library(lubridate)
library(hms)
library(glue)
library(arrow)

locations <- c("Hays Woods", "Upper St. Clair", "Rural site")

base_date <- ymd_hms("2026-08-31 07:00:00", tz = "EST")

fake_session_data <- tibble(
  session_start_time = c(base_date, base_date - days(4), base_date - days(10)),
  session_location = locations,
  session_nets = c("A, B, C")
) |>
  mutate(
    session_id = str_c(session_location, as_date(session_start_time), sep = " ")
  )

paths <- fake_session_data |>
  mutate(
    path = as.character(glue("test_data/session_data/{session_id}.parquet"))
  ) |>
  pull(path)

split_data <- fake_session_data |>
  group_split(session_id)

walk2(split_data, paths, write_parquet)
