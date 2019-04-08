library(rlang)

# expr_type <- function(x) {
#   if (rlang::is_syntactic_literal(x)) {
#     "constant"
#   } else if (is.symbol(x)) {
#     "symbol"
#   } else if (is.call(x)) {
#     "call"
#   } else if (is.pairlist(x)) {
#     "pairlist"
#   } else {
#     typeof(x)
#   }
# }
# 
# switch_expr <- function(x, ...) {
#   switch(expr_type(x),
#          ...,
#          stop("Don't know how to handle type ", typeof(x), call. = FALSE)
#   )
# }
# 
# flat_map_chr <- function(.x, .f, ...) {
#   purrr::flatten_chr(purrr::map(.x, .f, ...))
# }
# 
# find_assign <- function(x) unique(find_assign_rec(enexpr(x)))
# 
# find_assign_call <- function(x) {
#   if (is_call(x, "<-") && is_symbol(x[[2]])) {
#     lhs <- as_string(x[[2]])
#     children <- as.list(x)[-1]
#   } else {
#     lhs <- character()
#     children <- as.list(x)
#   }
#   
#   c(lhs, flat_map_chr(children, find_assign_rec))
# }
# 
# find_assign_rec <- function(x) {
#   switch_expr(x,
#               constant = ,
#               symbol = character(),
#               pairlist = flat_map_chr(x, find_assign_rec),
#               call = find_assign_call(x)
#   )
# }

setwd('..')

parsed <- parse_exprs(file('time.R'))

for (ex in parsed) {
  print(toString(ex))
}

# sf <- srcfile('time.R')
# try(parse(file = user_time, srcfile = sf))
# parsed <- getParseData(sf)
#close(user_time)

user <- new.env()
source('time.R', local = user)

solution <- new.env()
source('tests/solution.R', local = solution)

context('Module 01')
test_that('Require the readr package. @readr-package', {
  expect('readr' %in% (.packages()), 'Have you required the `readr` package in `time.R` with the `library()` function?')
})

test_that('Read the titles data. @read-titles-csv', {
  expect('titles' %in% ls(envir = user), 'Does the `titles` data frame exist in `time.R`?')
  expect(isTRUE(all_equal(user$titles, solution$titles)), 'Are you using the `read_csv()` function from the `readr` package to read in the `titles.csv` file?')
})

test_that('Read the stats data. @read-stats-csv', {
  expect('stats' %in% ls(envir = user), 'Does the `titles` data frame exist in `time.R`?')
  expect(isTRUE(all_equal(user$stats, solution$stats)), 'Are you using the `read_csv()` function from the `readr` package to read in the `stats.csv` file?')
})

test_that('Require the dplyr package. @dplyr-package', {
  expect('dplyr' %in% (.packages()), 'Have you required the `dplyr` package in `time.R` with the `library()` function?')
})

test_that('Join titles and stats. @join-titles-stats', {
  expect('books' %in% ls(envir = user), 'Does the `books` data frame exist in `time.R`?')
  expect(isTRUE(all_equal(user$books, solution$books)), 'Are you joining the `titles` and `stats` data frames with `full_join()`?')
})

test_that("Find Dickens' Works @filter-data", {
  expect('dickens' %in% ls(envir = user), 'Does the `dickens` data frame exist in `time.R`?')
  expect(isTRUE(all_equal(user$dickens, solution$dickens)), 'Does the `dickens` data frame only contain his works?')
})

test_that('Refining Columns. @refine-columns', {
  expect('dickens_stats' %in% ls(envir = user), 'Does the `dickens_stats` data frame exist in `time.R`?')
  expect(isTRUE(all_equal(user$dickens_stats, solution$dickens_stats)), 'Does the `dickens_stats` data frame have the correct columns?')
})

test_that('Importing Year Published. @read-published-csv', {
  expect('published' %in% ls(envir = user), 'Does the `published` data frame exist in `time.R`?')
  expect(isTRUE(all_equal(user$published, solution$published)), 'The `published` data frame should have an `id` and a `year` column.')
})

test_that('Joining year published. @join-dickens-published', {
  expect('time' %in% ls(envir = user), 'Does the `time` data frame exist in `time.R`?')
  expect(isTRUE(all_equal(user$time, solution$time)), 'Are you joining the `dickens_stats` and `published` data frames with `full_join()`?')
})

test_that('Require the tidyr package. @tidyr-package', {
  expect('tidyr' %in% (.packages()), 'Have you required the `tidyr` package in `time.R` with the `library()` function?')
})

test_that('Reshaping data frames. @reshape-time', {
  expect('time_long' %in% ls(envir = user), 'Does the `time_long` data frame exist in `time.R`?')
  expect(isTRUE(all_equal(user$time_long, solution$time_long)), 'Are you using the `gather()` function to reshape the `time` data frame?')
})

test_that('Require the ggplot2 package. @ggplot2-package', {
  expect('ggplot2' %in% (.packages()), 'Have you required the `ggplot2` package in `time.R` with the `library()` function?')
})

# test_that('Creating a Line Plot. @ggplot-call', {
# })
# 
# test_that('Creating a Line Plot. @line-plot', {
# })
# 
# test_that('Plot Configuration. @aes', {
# })

