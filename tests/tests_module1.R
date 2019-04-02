setwd('..')
source('time.R')

library('assertthat')

context('Module 01')
test_that('@time', {
  expect(see_if(102 == 102), "Doesn't Pass")
  expect(see_if(102 == 102), "Doesn't Pass")
  expect(see_if(102 == 102), "Doesn't Pass")
})