library('testthat')
library('mockery')
library('assertthat')

g = function(y) y
f = function(x) g(x) + 1

test_that('demonstrate mock object usage', {
  # mocks can specify behavior
  mock = mock(100)
  stub(f, 'g', mock)
  result = f(5)
  expect_equal(result, 102, info = 'Wrong number or arguments')

  expect_called(mock, 1)
  expect_args(mock, 1, 5)
})