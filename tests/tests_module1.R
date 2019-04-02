setwd('..')
source('time.R')

library('assertthat')

context('Module 01')
test_that('@time', {
  #assertthat::assert_that(101 == 102, msg = 'Not Equal!')
  # assertthat::assert_that(identical(101, 102), msg = 'Blah!')
  expect(see_if(102 == 102, 102 == 103), 'Blah!!!')
  expect(see_if(102 == 102, 102 == 103), 'Blah!!!')
  expect(see_if(102 == 102, 102 == 103), 'Blah!!!')
})

# test_that('@time2', {
#   assertthat::assert_that(101 == 102, msg = 'Error!!!!')
#   assertthat::assert_that(102 == 103, msg = 'Another Error!')
# })