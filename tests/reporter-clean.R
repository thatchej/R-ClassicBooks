expectation_type <- function(exp) {
  stopifnot(is.expectation(exp))
  gsub("^expectation_", "", class(exp)[[1]])
}

expectation_success <- function(exp) {
  expectation_type(exp) == "success"
}

expectation_failure <- function(exp) {
  expectation_type(exp) == "failure"
}

expectation_error <- function(exp) {
  expectation_type(exp) == "error"
}

expectation_skip <- function(exp) {
  expectation_type(exp) == "skip"
}

expectation_warning <- function(exp) {
  expectation_type(exp) == "warning"
}

expectation_broken <- function(exp) {
  expectation_failure(exp) || expectation_error(exp)
}
expectation_ok <- function(exp) {
  expectation_type(exp) %in% c("success", "warning")
}

CleanReporter <- R6::R6Class("CleanReporter",
  inherit = Reporter,
  public = list(
    results = list(),
    n = 0L,
    has_tests = FALSE,
    contexts = NA_character_,

    start_context = function(context) {
      self$contexts[self$n + 1] <- context
    },

    add_result = function(context, test, result) {
      self$has_tests <- TRUE
      self$n <- self$n + 1L
      self$results[[self$n]] <- result
    },

    end_reporter = function() {
      if (!self$has_tests) {
        return()
      }

      for (i in 1:self$n) {

        if (!is.na(self$contexts[i])) {
          self$cat_line(crayon::bold(self$contexts[i], "Tests\n---------------"))
        }

        result <- self$results[[i]]

        if (expectation_success(result)) {
          self$cat_line(crayon::green(paste0(result$test, ':', i, ':', 'passed')), "\n")
        } else if (expectation_broken(result)) {
          self$cat_line(crayon::red(paste0(result$test, ':', i, ':', 'failed')))
          msg <- gsub("(^|\n)", "\\1  ", format(result))
          self$cat_line(msg, "\n")
        } else {
          self$cat_line(
            result$test, ':', i, ':', toupper(expectation_type(result)), " ",
            format(result)
          )
        }
      }
    }
  )
)