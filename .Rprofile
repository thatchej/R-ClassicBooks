#### -- Packrat Autoloader (version 0.5.0) -- ####
source("packrat/init.R")
#### -- End Packrat Autoloader -- ####

packrat::restore()

.run <- new.env()
source("run_tests.R", local = .run)
attach(.run)