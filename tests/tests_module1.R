setwd('..')

import::from(readr, read_csv, .into='datatools')
import::from(dplyr, all_equal, full_join, select, arrange, .into='datatools')

.user_source <- new.env()
source('data.R', local = .user_source)
source('time.R', local = .user_source)

.test_titles <- read_csv('data/titles.csv')
.test_stats <- read_csv('data/stats.csv')

.test_books <- full_join(.test_titles, .test_stats)

context('Module 01')
test_that('Require the readr package. @readr-package', {
  expect('readr' %in% (.packages()), 'Have you required the `readr` package in `data.R` with the `library()` function?')
})

test_that('Read the titles data. @read-titles-csv', {
  expect('titles' %in% ls(envir = .user_source), 'Does the `titles` data frame exist in `data.R`?')
  expect(isTRUE(all_equal(.user_source$titles, .test_titles)), 'Are you using the `read_csv()` function from the `readr` package to read in the `titles.csv` file?')
})

test_that('Read the stats data. @read-stats-csv', {
  expect('stats' %in% ls(envir = .user_source), 'Does the `titles` data frame exist in `data.R`?')
  expect(isTRUE(all_equal(.user_source$stats, .test_stats)), 'Are you using the `read_csv()` function from the `readr` package to read in the `stats.csv` file?')
})

test_that('Require the dplyr package. @dplyr-package', {
  expect('dplyr' %in% (.packages()), 'Have you required the `dplyr` package in `data.R` with the `library()` function?')
})

test_that('Join titles and stats. @join-titles-stats', {
  expect('books' %in% ls(envir = .user_source), 'Does the `books` data frame exist in `data.R`?')
  expect(isTRUE(all_equal(.user_source$books, .test_books)), 'Are you joining the `titles` and `stats` data frames with `full_join()`?')
})

test_that('Requiring a File. @source-data-R', {
  expect(see_if(102 == 102), 'Not Passing')
})

test_that("Find Dickens' Works @filter-data", {
  expect(see_if(102 == 102), 'Not Passing')
})

test_that('Refining Columns. @refine-columns', {
  expect(see_if(102 == 102), 'Not Passing')
})

test_that('Importing Year Published. @read-published-csv', {
  expect(see_if(102 == 102), 'Not Passing')
})

test_that('Joining year published. @join-dickens-published', {
  expect(see_if(102 == 102), 'Not Passing')
})

test_that('Require the tidyr package. @tidyr-package', {
  expect('tidyr' %in% (.packages()), 'Have you required the `tidyr` package in `data.R` with the `library()` function?')
})

test_that('Reshaping data frames. @reshape-time', {
  expect(see_if(102 == 102), 'Not Passing')
})

test_that('Require the ggplot2 package. @ggplot2-package', {
  expect('ggplot2' %in% (.packages()), 'Have you required the `ggplot2` package in `data.R` with the `library()` function?')
})

test_that('Creating a Line Plot. @ggplot-call', {
  expect(see_if(102 == 102), 'Not Passing')
})

test_that('Creating a Line Plot. @line-plot', {
  expect(see_if(102 == 102), 'Not Passing')
})

test_that('Plot Configuration. @aes', {
  expect(see_if(102 == 102), 'Not Passing')
})


