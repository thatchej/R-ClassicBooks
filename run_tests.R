tests <- function(module = 'all', reporter = 'tap') {
  if ('testthat' %in% rownames(installed.packages())) {
    library('testthat')
    library('mockery')
    if (module == 'module1') {
      fpath <- paste0('tests/tests_', module, '.R')
      if(test_file_exists(fpath)) {
        test_file(fpath, reporter = reporter)
      } else {
        print('The test file is missing check your `tests` directory.') 
      }
    } else if (module == 'all') {
      test_dir('tests', reporter = reporter)
    } else {
      print(paste('No module named:', module))
    }
  } else {
    warning('Please run `packrat::restore()` to install the needed packages.')
  }
}

if (!interactive()) {
  source('tests/reporter-json.R')
  library('optparse')
  option_list <- list(
    make_option(c('-m', '--module'), type = 'character', default = 'all',
                help='Module to test.'),
    make_option(c('-r', '--reporter'), type = 'character', default = 'junit',
                help='Reporter to use.')
  )
  opt <- parse_args(OptionParser(option_list=option_list))
  test_results <- tests(opt$module, opt$reporter)
}