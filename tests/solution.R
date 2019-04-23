library(readr)
library(dplyr)
library(stringr)
library(tidyr)
library(ggplot2)
library(testthat)

capture_condition(titles <- read_csv('data/titles.csv'))
capture_condition(stats <- read_csv('data/stats.csv'))

capture_condition(books <- full_join(titles, stats))

capture_condition(dickens <- filter(books, str_detect(author, 'Dickens')))

capture_condition(dickens_stats <- select(dickens, id, words, sentences, to_be_verbs, contractions, pauses, cliches, similes))

capture_condition(published <- read_csv('data/published.csv'))

capture_condition(time <- full_join(dickens_stats, published))

capture_condition(time_long <- gather(time, type, value, words:similes))

capture_condition(p <- ggplot(time_long , aes(year, value, color = type)) + geom_line())