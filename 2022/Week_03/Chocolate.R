# The purpose of this script is to partake in Week 3 of the TidyTuesday project.

# Load the required packages
library(tidyverse)

# Read in the latest data
RawData <- tidytuesdayR::last_tuesday() %>%
  tidytuesdayR::tt_load_gh() %>%
  tidytuesdayR::tt_download()

# Extract the Chocolate data
ChocData <- RawData$chocolate

Rankings <- ChocData %>%
  group_by(country_of_bean_origin) %>%
  summarize(Count = n(),
            rating = mean(rating)) %>%
  filter(Count > 20) %>%
  arrange(-rating)

ChocData %>%
  filter(country_of_bean_origin %in% Rankings$country_of_bean_origin) %>%
  mutate(country_of_bean_origin = factor(country_of_bean_origin, levels = rev(Rankings$country_of_bean_origin))) %>%
  ggplot(aes(x = rating, y = country_of_bean_origin)) +
  ggridges::geom_density_ridges() +
  scale_x_continuous(limits = c(2,5))
