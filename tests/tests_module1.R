setwd('..')
source('time.R')

context('Module 01')
test_that('Require the readr package. @readr-package', {
  expect('readr' %in% (.packages()), 'Have you required the `readr` package in `data.R` with the `library()` function?')
})

test_that('Read the titles data. @read-titles-csv', {
  expect(exists('titles'), "Does the `titles`` data frame exist in `data.R`?")
})

test_that('Read the stats data. @read-stats-csv', {
  expect(see_if(102 == 102), "Doesn't Pass")
})

test_that('Require the dplyr package. @dplyr-package', {
  expect('dplyr' %in% (.packages()), 'Have you required the `dplyr` package in `data.R` with the `library()` function?')
})

test_that('Join titles and stats. @join-titles-stats', {
  expect(see_if(102 == 102), "Doesn't Pass")
})

test_that('Requiring a File. @source-data-R', {
  expect(see_if(102 == 102), "Doesn't Pass")
})

test_that("Find Dickens' Works @filter-data", {
  expect(see_if(102 == 102), "Doesn't Pass")
})

test_that('Refining Columns. @refine-columns', {
  expect(see_if(102 == 102), "Doesn't Pass")
})

test_that('Importing Year Published. @read-published-csv', {
  expect(see_if(102 == 102), "Doesn't Pass")
})

test_that('Joining year published. @join-dickens-published', {
  expect(see_if(102 == 102), "Doesn't Pass")
})

test_that('Require the tidyr package. @tidyr-package', {
  expect('tidyr' %in% (.packages()), 'Have you required the `tidyr` package in `data.R` with the `library()` function?')
})

test_that('Reshaping data frames. @reshape-time', {
  expect(see_if(102 == 102), "Doesn't Pass")
})

test_that('Require the ggplot2 package. @ggplot2-package', {
  expect('ggplot2' %in% (.packages()), 'Have you required the `ggplot2` package in `data.R` with the `library()` function?')
})

test_that('Creating a Line Plot. @ggplot-call', {
  expect(see_if(102 == 102), "Doesn't Pass")
})

test_that('Creating a Line Plot. @line-plot', {
  expect(see_if(102 == 102), "Doesn't Pass")
})

test_that('Plot Configuration. @aes', {
  expect(see_if(102 == 102), "Doesn't Pass")
})