# The purpose of this script is to partake in Week 3 of the TidyTuesday project.

# Load the required packages
library(tidyverse)


RawData <- tidytuesdayR::last_tuesday() %>%
  tidytuesdayR::tt_load_gh() %>%
  tidytuesdayR::tt_download()

ChocData <- RawData$chocolate