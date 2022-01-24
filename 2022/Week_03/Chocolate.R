# The purpose of this script is to partake in Week 3 of the TidyTuesday project.

# Load the required packages
library(tidyverse)
library(tidytuesdayR)
library(wordcloud)

# Read in the latest data
RawData <- as.Date("2022-01-18") %>%
  tt_load_gh() %>%
  tt_download()

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


df <- str_split_fixed(ChocData$most_memorable_characteristics, ",", 10) %>%
  as_tibble() %>%
  mutate(OriginCountry = ChocData$company_location) %>%
  pivot_longer(V1:V10) %>%
  mutate(value = trimws(value)) %>%
  filter(value != "") %>%
  group_by(value) %>%
  summarize(Count = n())


set.seed(1234) # for reproducibility

wordcloud(words = df$value, freq = df$Count, min.freq = 1,
          max.words=200, random.order=FALSE, rot.per=0.35)
