library(glue)

JsonReporter <- R6::R6Class("JsonReporter",
  inherit = Reporter,
  public = list(
    timer = NULL,
    suite_time = 0,
    tests = 0,
    skipped = 0,
    failures = 0,
    errors = 0,
    tags = list(),
    heading = NULL,
    suite = NULL,
    test_results = data.frame(tag = character(), result = character(), passed = character(), time = character()),

    elapsed_time = function() {
      time <- round((private$proctime() - self$timer)[["elapsed"]], 2)
      self$timer <- private$proctime()
      time
    },

    reset_suite = function() {
      self$errors <- 0
      self$failures <- 0
      self$skipped <- 0
      self$tests <- 0
      self$suite_time <- 0
    },

    start_reporter = function() {
      self$timer <- private$proctime()
      self$reset_suite()
    },

    end_context = function(context) {
      suite_time <- as.character(round(self$suite_time, 3))
      timestamp <- private$timestamp()

      self$heading <- glue('\t"suite": "{context}",\n\t"timestamp": "{timestamp}",\n\t"suiteTime": {suite_time},\n\t"tests": {self$tests},\n\t"failures": {self$failures},\n\t"errors": {self$errors},\n\t"skipped": {self$skipped},')

      self$reset_suite()
    },

    add_result = function(context, test, result) {
      tag <- regmatches(test, gregexpr('@(.*)', test))[[1]]

      if (!tag %in% self$tags) {
        self$tests <- self$tests + 1L
        self$tags[[nrow(self$test_results) + 1L]] <- tag
        time <- self$elapsed_time()
        self$suite_time <- self$suite_time + time

        if (testthat:::expectation_broken(result)){
          passed <- 'false'
        } else if (testthat:::expectation_ok(result)){
          passed <- 'true'
        }

        if (testthat:::expectation_error(result)) {
          self$errors <- self$errors + 1L
        } else if (testthat:::expectation_failure(result)) {
          self$failures <- self$failures + 1L
        } else if (testthat:::expectation_skip(result)) {
          self$skipped <- self$skipped + 1L
        }

        self$test_results <- rbind(self$test_results, data.frame(tag = tag, result = format(result), passed = passed, time = toString(time)))
      }
    },

    end_reporter = function() {
      full_pass <- all(as.logical(self$test_results$passed))
      
      self$cat_line('{')
      self$cat_line(self$heading)
      self$cat_line(glue('"passed": {tolower(as.character(full_pass))},'))
      self$cat_line('"testResults": [')

      for (row in 1:nrow(self$test_results)) {
        tag <- self$test_results[row, "tag"]
        time  <- self$test_results[row, "time"]
        passed <- self$test_results[row, "passed"]
        result  <- self$test_results[row, "result"]
        comma <- ','

        if (row == nrow(self$test_results)) {
          comma <- ''
        }

        self$cat_line(glue('\t{{ "tag": "{tag}", "time": {time}, "passed": {passed}, "error": {{ "message": "{result}"}} }}{comma}'))

      }

      self$cat_line(']\n}')

    }
  ),

  private = list(
    proctime = function() {
      proc.time()
    },
    timestamp = function() {
      toString(Sys.time())
    }
  )
)