library(tidyverse)
library(tidytext)
library(textdata)
library(wordcloud)
# Get the Data

critic <- readr::read_tsv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-05/critic.tsv')
user_reviews <- readr::read_tsv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-05/user_reviews.tsv')
items <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-05/items.csv')
villagers <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-05-05/villagers.csv')


pal <- c("#AD7542", "#FF010B", "#FCCB45", "#53B156", "#F09B48")


bad_user_reviews <- user_reviews %>%
  filter(grade < 1) %>%
  unnest_tokens(word, text) %>%
  count(word, sort = TRUE) %>%
  anti_join(stop_words) %>%
  inner_join(get_sentiments("bing")) %>%
  filter(sentiment == 'negative') %>%
  with(wordcloud(word, n, max.words = 100, colors = pal))


