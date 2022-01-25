# The purpose of this script is to partake in Week 4 of the TidyTuesday project.

# Load the required packages
library(tidyverse)

# Read in the latest data
RawData <- as.Date("2022-01-25") %>%
  tidytuesdayR::tt_load_gh() %>%
  tidytuesdayR::tt_download()


GameData <- RawData$ratings %>%
  merge(RawData$details, all = TRUE, by = "id")
