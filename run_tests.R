library('testthat')
library('optparse')

print(getwd())

option_list <- list(
    make_option(c("-m", "--module"), type="character", default="all",
        help="Module to test."),
    make_option(c("-r", "--reporter"), type="character", default="summary",
        help="Reporter to use.")
    )
opt <- parse_args(OptionParser(option_list=option_list))

test <- function(module='all', reporter='progress') {
  if (module == "module1") {
    test_file("tests/tests_module1.R", reporter=reporter)
  }
  if (module == "module2") {
    test_file("tests/tests_module2.R", reporter=reporter)
  }
  if (module == "all") {
    test_dir("tests", reporter=reporter)
  }

}

if (!interactive()) {
  test_results <- test(opt$module, opt$reporter)
}

