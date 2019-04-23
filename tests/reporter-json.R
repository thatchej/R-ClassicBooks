library(testthat)

.expectation_type <- function(exp) {
  stopifnot(is.expectation(exp))
  gsub('^expectation_', '', class(exp)[[1]])
}

.expectation_success <- function(exp) {
  .expectation_type(exp) == 'success'
}

.expectation_failure <- function(exp) {
  .expectation_type(exp) == 'failure'
}

.expectation_error <- function(exp) {
  .expectation_type(exp) == 'error'
}

.expectation_skip <- function(exp) {
  .expectation_type(exp) == 'skip'
}

.expectation_warning <- function(exp) {
  .expectation_type(exp) == 'warning'
}

.expectation_broken <- function(exp) {
  .expectation_failure(exp) || .expectation_error(exp)
}
.expectation_ok <- function(exp) {
  .expectation_type(exp) %in% c('success', 'warning')
}

JsonReporter <- R6::R6Class('JsonReporter',
  inherit = Reporter,
  public = list(
    results = list(),
    tags = list(),
    n = 0L,
    has_tests = FALSE,
    passed = list(),
    contexts = NA_character_,
                                 
    start_context = function(context) {
      self$contexts[self$n + 1] <- context
    },
                                 
    add_result = function(context, test, result) {
      self$has_tests <- TRUE
      tag <- regmatches(test, gregexpr('@(.*)', test))[[1]]
      if (!tag %in% self$tags) {
        self$n <- self$n + 1L
        self$results[[self$n]] <- result
        self$tags[[self$n]] <- tag
      }
      
      if (.expectation_ok(result)){
        self$passed[[self$n]] <- TRUE
      }
    },
                                 
    end_reporter = function() {
      if (!self$has_tests) {
        return()
      }

      if (all(as.logical(self$passed))) {
        passed <- 'true'
      } else {
        passed <- 'false'
      }
      
      self$cat_line('{ "passed": ', passed, '" testResults": [')
      for (i in 1:self$n) {

        result <- self$results[[i]]
        result$test <- gsub('@(.*)', '', result$test)
        
        self$cat_line('{ "tag": "', self$tags[[i]], '",')

        if (.expectation_success(result)) {
          self$cat_line('"passed": true, "error": null}')
        } else if (.expectation_broken(result)) {
          self$cat_line('"passed": false, "error": { "message": "', format(result), '"}}' )
        }
        
        if (i != self$n) {
          self$cat_line(',')
        }
      }
      self$cat_line(']}')
    }
  )
)
