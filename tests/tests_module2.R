setwd('..')
source('reading.R')

library('assertthat')

context('Module 02')
test_that('@reading', {
  expect(see_if(102 == 102, 102 == 103), 'The value is not correct 1!')
  expect(see_if(102 == 102, 102 == 103), 'The value is not correct 2!')
  expect(see_if(102 == 102, 102 == 103), 'The value is not correct 3!')
  expect(see_if(102 == 102, 103 == 103), 'The value is not correct 4!')
})

test_that('@reading2', {
  expect(see_if(102 == 102, 102 == 103), 'The value is not correct 1!')
  expect(see_if(102 == 102, 102 == 103), 'The value is not correct 2!')
  expect(see_if(102 == 102, 102 == 103), 'The value is not correct 3!')
  expect(see_if(102 == 102, 103 == 103), 'The value is not correct 4!')
})