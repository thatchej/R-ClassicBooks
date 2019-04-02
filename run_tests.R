library('optparse')
library('assertthat')
library('testthat')
library('checkmate')

option_list <- list(
    make_option(c("-m", "--module"), type="character", default="all",
        help="Module to test."),
    make_option(c("-r", "--reporter"), type="character", default="progress",
        help="Reporter to use.")
    )
opt <- parse_args(OptionParser(option_list=option_list))

tests <- function(module='all', reporter='progress') {
  if (module == "module1" || module == "module2") {
    fpath <- paste0('tests/tests_', module, '.R')
    if(test_file_exists(fpath)) {
      test_file(fpath, reporter=reporter)
    } else {
      print('The test file is missing check your `tests` directory.') 
    }
  } else if (module == "all") {
    test_dir("tests", reporter=reporter)
  } else {
    print(paste('No module named:', module))
  }
}

if (!interactive()) {
  source('tests/reporter-json.R')
  test_results <- tests(opt$module, opt$reporter)
}